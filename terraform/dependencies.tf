data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "win2019" {
  name = var.rg_name
}

data "azurerm_resource_group" "automation" {
  name = var.automation_account_rg_name
}

data "azurerm_image" "image" {
  name                = "${var.image_name}.${var.image_version}"
  resource_group_name = var.image_rg_name
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = data.azurerm_resource_group.win2019.name
}

resource "azurerm_key_vault_key" "des" {
  name         = var.des_key_name
  key_vault_id = data.azurerm_key_vault.kv.id
  key_type     = "RSA-HSM"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_disk_encryption_set" "des" {
  name                = var.des_name
  resource_group_name = data.azurerm_resource_group.win2019.name
  location            = data.azurerm_resource_group.win2019.location
  key_vault_key_id    = azurerm_key_vault_key.des.id

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "kv_crypto_des" {
  scope                = data.azurerm_resource_group.win2019.id
  role_definition_name = "Key Vault Crypto Officer"
  principal_id         = azurerm_disk_encryption_set.des.identity.0.principal_id
}

resource "azurerm_key_vault_secret" "admin_name" {
  name         = var.admin_name_secret_name
  value        = var.admin_name_secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "admin_password" {
  name         = var.admin_password_secret_name
  value        = var.admin_password_secret_value
  key_vault_id = data.azurerm_key_vault.kv.id
}