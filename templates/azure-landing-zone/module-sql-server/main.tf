resource "random_password" "password" {
  length           = 16
  special          = true
  upper            = true
  min_numeric      = 1
  min_special      = 1
  override_special = "_%@"
}

resource "random_string" "user" {
  upper       = false
  special     = false
  lower       = true
  min_numeric = 1
  length      = 12
}

resource "azurerm_sql_server" "sqlserver" {
  name                         = lower(var.sql_server_name)
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = var.sql_server_version
  administrator_login          = random_string.user.result
  administrator_login_password = random_password.password.result
  tags                         = var.tags
}

resource "azurerm_mssql_server_extended_auditing_policy" "auditing_policy" {
  server_id                               = azurerm_sql_server.sqlserver.id
  storage_endpoint                        = var.storage_primary_blob_endpoint
  storage_account_access_key              = var.storage_primary_access_key
  storage_account_access_key_is_secondary = true
  retention_in_days                       = var.sql_retention_in_days
}

resource "azurerm_key_vault_secret" "user" {
  name         = format("%s%s", azurerm_sql_server.sqlserver.name, "-admin-user")
  value        = azurerm_sql_server.sqlserver.administrator_login
  key_vault_id = var.keyvaut_id
}

resource "azurerm_key_vault_secret" "pass" {
  name         = format("%s%s", azurerm_sql_server.sqlserver.name, "-admin-pass")
  value        = azurerm_sql_server.sqlserver.administrator_login_password
  key_vault_id = var.keyvaut_id
}