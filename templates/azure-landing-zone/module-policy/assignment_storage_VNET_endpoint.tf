resource "azurerm_policy_assignment" "storage_VNET_endpoint" {
  count                = contains(var.policylist, "storage_VNET_endpoint") ? 1 : 0
  name                 = "Storage Accounts should use a VNET service endpoint"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/60d21c4f-21a3-4d94-85f4-b924e6aeeda4"
  description          = "policy audits any Storage Account not configured to use a virtual network service endpoint."
  display_name         = "Storage Accounts should use a VNET service endpoint"
}