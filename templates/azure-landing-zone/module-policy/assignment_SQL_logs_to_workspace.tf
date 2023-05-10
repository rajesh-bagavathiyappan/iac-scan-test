resource "azurerm_policy_assignment" "SQL_logs_to_workspace" {
  count                = contains(var.policylist, "SQL_logs_to_workspace") ? 1 : 0
  name                 = "Azure SQL DB server diagnostics to Log Analytics workspace"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7ea8a143-05e3-4553-abfe-f56bef8b0b70"
  description          = "Enables auditing logs for Azure SQL Database server and stream the logs to a Log Analytics workspace when any SQL Server which is missing this auditing is created or updated"
  display_name         = "Azure SQL DB server diagnostics to Log Analytics workspace"

  parameters = <<PARAMETERS
{
  "logAnalyticsWorkspaceId": {
    "value": "${var.logAnalyticsWorkspaceId}"
  }
}
PARAMETERS
location=var.location
identity {
type="SystemAssigned"

}
}