resource "azurerm_policy_assignment" "storage_private_link_usage" {
  count                = contains(var.policylist, "storage_private_link_usage") ? 1 : 0
  name                 = "Storage accounts should use private link"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6edd7eda-6dd8-40f7-810d-67160c639cd9"
  description          = "Audit Storage accounts which not having private link"
  display_name         = "Storage accounts should use private link"
}