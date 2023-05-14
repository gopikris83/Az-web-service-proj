terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = ">= 3.30"
    }
  }
}

provider "azurerm" {
  features {}  
}

terraform {
  backend "azurerm" {
    storage_account_name = "nodejssa202304"
    container_name       = "tfbackend"
    key                  = "test.state"
    subscription_id      = "05668dbd-b4a9-47bf-9be0-f93a45c7ca62"
    tenant_id            = "1579c998-5e46-4c96-8a84-3ba995b0aea1"
    resource_group_name  = "aznodejsapp-rg"
  }
}
