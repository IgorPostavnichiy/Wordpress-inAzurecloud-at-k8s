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

  # Create public ip
resource "azurerm_public_ip" "product" {
  name                = "PublicIPForLB"
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name
  allocation_method   = "Static"
}

  # Create load balancer
resource "azurerm_lb" "product" {
  name                = "LoadBalancer"
  location            = azurerm_resource_group.product.location
  resource_group_name = azurerm_resource_group.product.name

  frontend_ip_configuration {
    name                 = "LoadBalancer_lb_public_ip"
    public_ip_address_id = azurerm_public_ip.product.id
  } 
}

  resource "azurerm_lb_rule" "product" {
    loadbalancer_id                = azurerm_lb.product.id
    name                           = "LB_TCP_80"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "LoadBalancer_lb_public_ip"
}

