resource "azurerm_policy_assignment" "Public_access_to_SQL_DB" {
  count                = contains(var.policylist, "Public_access_to_SQL_DB") ? 1 : 0
  name                 = "Public network access on Azure SQL DB should be disabled"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1b8ca024-1d5c-4dec-8995-b1a932b41780"
  description          = "Disabling the public network access property improves security by ensuring your Azure SQL Database can only be accessed from a private endpoint"
  display_name         = "Public network access on Azure SQL DB should be disabled"
}