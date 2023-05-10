resource "azurerm_policy_assignment" "secure_storage_transfer" {
  count                = contains(var.policylist, "secure_storage_transfer") ? 1 : 0
  name                 = "Secure transfer to storage accounts should be enabled"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"
  description          = "Storage account HTTPs only"
  display_name         = "Secure transfer to storage accounts should be enabled"
}