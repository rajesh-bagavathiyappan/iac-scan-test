resource "azurerm_subnet" "snet" {
  resource_group_name  = var.rg_name
  name                 = format("%s%02d", var.subnet_name, (1 + var.subnet_offset))
  address_prefixes     = var.subnet_address_prefixes
  virtual_network_name = var.vnet_name
  service_endpoints    = var.Service_Endpoints
}

resource "azurerm_network_security_group" "nsg" {
  name                = format("%s-nsg%02d", var.subnet_name, (1 + var.subnet_offset))
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "rules" {
  name                        = lookup(var.nsg_rules[count.index], "name")
  count                       = length(var.nsg_rules)
  priority                    = lookup(var.nsg_rules[count.index], "priority")
  direction                   = lookup(var.nsg_rules[count.index], "direction")
  access                      = lookup(var.nsg_rules[count.index], "access")
  protocol                    = "*"
  source_port_range           = lookup(var.nsg_rules[count.index], "source_port_range")
  destination_port_range      = lookup(var.nsg_rules[count.index], "destination_port_range")
  source_address_prefix       = lookup(var.nsg_rules[count.index], "source_address_prefix")
  destination_address_prefix  = lookup(var.nsg_rules[count.index], "destination_address_prefix")
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "nsgAssociate" {
  subnet_id                 = azurerm_subnet.snet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}