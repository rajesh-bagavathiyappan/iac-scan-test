resource "azurerm_recovery_services_vault" "vault" {
  name                = var.recovery_services_vault_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.recovery_services_vault_sku
  soft_delete_enabled = true
  tags                = var.tags
}