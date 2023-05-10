resource "azurerm_api_management" "example" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.rg_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.apim_sku_name
  virtual_network_type = "Internal"
  virtual_network_configuration {
      subnet_id = var.apim_subnet_id
  }
  tags                = var.tags
}