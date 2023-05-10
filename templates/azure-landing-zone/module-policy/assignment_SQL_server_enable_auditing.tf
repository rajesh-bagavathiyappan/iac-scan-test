resource "azurerm_policy_assignment" "SQL_server_enable_auditing" {
  count                = contains(var.policylist, "SQL_server_enable_auditing") ? 1 : 0
  name                 = "Auditing on SQL server should be enabled"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a6fb4358-5bf4-4ad7-ba82-2cd2f41ce5e9"
  description          = "Auditing on your SQL Server should be enabled to track database activities across all databases on the server and save them in an audit log."
  display_name         = "Auditing on SQL server should be enabled"
}