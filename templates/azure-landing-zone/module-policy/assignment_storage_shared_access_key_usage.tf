resource "azurerm_policy_assignment" "storage_shared_access_key_usage" {
  count                = contains(var.policylist, "storage_shared_access_key_usage") ? 1 : 0
  name                 = "Storage accounts should prevent shared key access"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8c6a50c6-9ffd-4ae7-986f-5fa6111f9a54"
  description          = "Audit Storage accounts accessing via shared key access"
  display_name         = "Storage accounts should prevent shared key access"
}