resource "azurerm_policy_assignment" "TLS_1_2_SQL_DB" {
  count                = contains(var.policylist, "TLS_1_2_SQL_DB") ? 1 : 0
  name                 = "Azure SQL DB should have the minimal TLS version of 1.2"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/32e6bbec-16b6-44c2-be37-c5b672d103cf"
  description          = "etting minimal TLS version to 1.2 improves security by ensuring your Azure SQL Database can only be accessed from clients using TLS 1.2."
  display_name         = "Azure SQL DB should have the minimal TLS version of 1.2"
}