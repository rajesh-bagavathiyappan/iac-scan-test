resource "azurerm_policy_assignment" "auditLockOnNetworking" {
  count                = contains(var.policylist, "auditLockOnNetworking") ? 1 : 0
  name                 = "Audit on Network Resource Lock"
  scope                = var.policyscope
  policy_definition_id = azurerm_policy_definition.auditLockOnNetworking[0].id
  description          = "Audit Network Resource Lock Enabled or Not"
  display_name         = "Audit on Network Resource Lock"

  metadata = <<METADATA
    {
    "category": "Demo"
    }
METADATA


}
