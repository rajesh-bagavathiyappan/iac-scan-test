output "output_subnet_id" {
  value = azurerm_subnet.snet.id
}

output "output_nsg_id" {
  value = azurerm_network_security_group.nsg.id
}