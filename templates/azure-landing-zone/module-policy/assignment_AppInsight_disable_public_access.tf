resource "azurerm_policy_assignment" "Blocked_Ingesion_Public_Network" {
  count                = contains(var.policylist, "Blocked_Ingesion_Public_Network") ? 1 : 0
  name                 = "AppInsight Blocked Ingesion Public Network"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1bc02227-0cb6-4e11-8f53-eb0b22eab7e8"
  description          = "Improve Application Insights security by blocking log ingestion and querying from public networks. Only private-link connected networks will be able to ingest and query logs of this component. Learn more at https://aka.ms/AzMonPrivateLink#configure-application-insights "
  display_name         = "AppInsight Blocked Ingesion Public Network"
}