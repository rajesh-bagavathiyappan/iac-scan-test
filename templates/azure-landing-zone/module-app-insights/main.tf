resource "azurerm_application_insights" "insights" {
  name                = var.app_insights_name
  location            = var.location
  resource_group_name = var.rg_name
  application_type    = "web"
  tags                = var.tags
}