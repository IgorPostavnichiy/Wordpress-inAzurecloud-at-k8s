terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstoragetest"
    storage_account_name = "tfstorageactest"
    container_name       = "containertest"
    key                  = "terraform.st"
  }

}

provider "azurerm" {
  features {}
}

