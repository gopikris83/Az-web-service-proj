terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.30"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tfstate" {
  name     = "aznodejsapp-rg"
  location = "West Europe"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "nodejssa202304"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = {
    environment = "test"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfbackend"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}