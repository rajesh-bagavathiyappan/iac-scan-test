resource "azurerm_policy_assignment" "sqlserverdbcpupercent" {
  count                = contains(var.policylist, "sqlserverdbcpupercent") ? 1 : 0
  name                 = "sqlserverdbcpupercent"
  scope                = var.policyscope
  policy_definition_id = azurerm_policy_definition.sqlserverdbcpupercent[0].id
  description          = "SQL Server DB CPU Percent"
  display_name         = "SQL Server DB CPU Percent"
  identity { type = "SystemAssigned" }
  location = var.location

  metadata = <<METADATA
    {
    "category": "Demo"
    }
METADATA


}
