variable "key_name" {
  default = "azacrsecret202304"
}

variable "key_value" {
  default = ""
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "tf-key-vault" {
  name                        = "azkeyvault202304"
  location                    = data.azurerm_resource_group.tf-rg.location
  resource_group_name         = data.azurerm_resource_group.tf-rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = ["Create", "Get", "List", "Delete" ]

    secret_permissions = ["Get", "List", "Delete"]

    storage_permissions = ["Get", "List", "Set", "Delete"]
  }
}


resource "azurerm_key_vault_secret" "keyvault_secret" {
  name         = var.key_name
  value        = var.key_value
  key_vault_id = azurerm_key_vault.tf-key-vault.id
  lifecycle {
    ignore_changes = [value, version]
  }
}
