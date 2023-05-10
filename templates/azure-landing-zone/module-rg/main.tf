resource "azurerm_resource_group" "rg01" {
  name     = format("%s%02d", var.rg_name, (1 + var.rg_offset))
  location = var.location
  tags     = var.tags
}