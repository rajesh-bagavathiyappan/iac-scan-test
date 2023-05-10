resource "azurerm_storage_account" "sta" {
  name                      = lower(var.storage_account_name)
  resource_group_name       = var.rg_name
  location                  = var.location
  account_tier              = var.storage_account_tier
  account_replication_type  = var.storage_account_replication_type
  enable_https_traffic_only = var.enable_https_traffic_only
  tags                      = var.tags
}
