resource "azurerm_policy_assignment" "namingconvention" {
  count                = contains(var.policylist, "namingconvention") ? 1 : 0
  name                 = "namingconvention"
  scope                = var.policyscope
  policy_definition_id = azurerm_policy_definition.namingconvention[0].id
  description          = "Naming convention for Storage"
  display_name         = "Naming-Convention-Assignment"

  parameters = <<PARAMETERS
{
  "namePattern": {
    "value": "xor????????"
  }
}
PARAMETERS
}