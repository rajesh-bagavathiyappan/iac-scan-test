resource "azurerm_policy_assignment" "VNET_flow_log_configure" {
  count                = contains(var.policylist, "VNET_flow_log_configure") ? 1 : 0
  name                 = "Flow logs should be configured and enabled for NSGs"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/62329546-775b-4a3d-a4cb-eb4bb990d2c0"
  description          = "Audit for network security groups to verify if flow logs are configured and if flow log status is enabled. Enabling flow logs allows to log information about IP traffic flowing through network security group. It can be used for optimizing network flows, monitoring throughput, verifying compliance, detecting intrusions and more."
  display_name         = "Flow logs should be configured and enabled for NSGs"
}