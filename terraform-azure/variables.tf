variable "resource_group_location" {
  type = string
  description = "Location of the resource group."
}

variable "agent_count" {
  default = 1
}


variable "azure_subscription_id" {
  type    = string
  default = "subscription_id"
}

variable "azure_client_id" {
  type    = string
  default = "client_id"
}

variable "azure_client_secret" {
  type    = string
  default = "client_secret"
}

variable "azure_tenant_id" {
  type    = string
  default = "tenant_id"
}

variable "location" {
  type    = string
  default = "eastus" 
}

variable "resource_group_name" {
  type    = string
  default = "my-resource-group"
}


variable "cluster_name" {
  type = string
  description = "AKS name in Azure"
}

variable "kubernetes_version" {
type = string
description = "Kubernetes version"
}

variable "system_node_count" {
type = number
description = "Number of AKS worker nodes"
}




