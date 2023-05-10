resource "azurerm_virtual_network" "main" {
  name                = format("%s%02d", var.vnet_name, (1 + var.vnet_offset))
  address_space       = var.vnet_addressspace
  location            = var.location
  resource_group_name = var.rg_name
}
  # ddos_protection_plan {
  #   id     = azurerm_network_ddos_protection_plan.ddos.id
#     enable = false
#   }
#  tags = var.tags
#}

 #resource "azurerm_network_ddos_protection_plan" "ddos" {
#   name                = format("%s-ddos%02d", var.vnet_name, (1 + var.vnet_offset))
#   location            = var.location
#   resource_group_name = var.rg_name
#   tags                = var.tags
# }
