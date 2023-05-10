output "storage_account_id" {
  value = azurerm_storage_account.sta.id
}

output "storage_primary_blob_endpoint" {
  value = azurerm_storage_account.sta.primary_blob_endpoint
}

output "storage_primary_access_key" {
  value = azurerm_storage_account.sta.primary_access_key
}