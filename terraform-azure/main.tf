resource "azurerm_resource_group" "product" {
  name            = var.resource_group_name
  location        = var.location
}


resource "azurerm_kubernetes_cluster" "product" {
  
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.product.name
  dns_prefix          = var.cluster_name
  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig"
  content  = azurerm_kubernetes_cluster.product.kube_config_raw
}



# Create DNS record
  resource "azurerm_dns_zone" "product" {
    name                = "wp-team.pp.ua"
    resource_group_name = azurerm_resource_group.product.name
}

# If you want to test deploy without Tekton and use manifest init.yml -> you need to delete this comments:

# # Create SQL Server
# resource "azurerm_mysql_server" "product" {
#   name                = "mysql-wpigor"
#   location            = azurerm_resource_group.product.location
#   resource_group_name = azurerm_resource_group.product.name

#   administrator_login          = "igorsql"
#   administrator_login_password = "I991$426yUQ"

#   sku_name   = "B_Gen5_2"
#   storage_mb = 5120
#   version    = "5.7"

#   auto_grow_enabled                 = true
#   backup_retention_days             = 30
#   geo_redundant_backup_enabled      = false
#   infrastructure_encryption_enabled = false
#   public_network_access_enabled     = true
#   ssl_enforcement_enabled           = false
#   ssl_minimal_tls_version_enforced  = "TLSEnforcementDisabled"
# }
# resource "azurerm_mysql_firewall_rule" "product" {
#   name                = "AllowAllIPs"
#   resource_group_name = azurerm_resource_group.product.name
#   server_name         = azurerm_mysql_server.product.name
#   start_ip_address    = "0.0.0.0"
#   end_ip_address      = "255.255.255.255"
# }

#   # Create public ip
# resource "azurerm_public_ip" "product" {
#   name                = "PublicIPForLB"
#   location            = azurerm_resource_group.product.location
#   resource_group_name = azurerm_resource_group.product.name
#   allocation_method   = "Static"
# }

#   # Create load balancer
# resource "azurerm_lb" "product" {
#   name                = "LoadBalancer"
#   location            = azurerm_resource_group.product.location
#   resource_group_name = azurerm_resource_group.product.name

#   frontend_ip_configuration {
#     name                 = "LoadBalancer_lb_public_ip"
#     public_ip_address_id = azurerm_public_ip.product.id
#   } 
# }

#   resource "azurerm_lb_rule" "product" {
#     loadbalancer_id                = azurerm_lb.product.id
#     name                           = "LB_TCP_80"
#     protocol                       = "Tcp"
#     frontend_port                  = 80
#     backend_port                   = 80
#     frontend_ip_configuration_name = "LoadBalancer_lb_public_ip"
# }

# resource "azurerm_dns_cname_record" "product" {
#   name                = "wordpress"
#   zone_name           = azurerm_dns_zone.product.name
#   resource_group_name = azurerm_resource_group.product.name
#   ttl                 = 300
#   record              = "wp-team.pp.ua"
# }
# resource "azurerm_dns_a_record" "product" {
#   name                = azurerm_dns_zone.product.name
#   zone_name           = azurerm_dns_zone.product.name
#   resource_group_name = azurerm_resource_group.product.name
#   ttl                 = 300
#   target_resource_id  = azurerm_public_ip.product.id
# }