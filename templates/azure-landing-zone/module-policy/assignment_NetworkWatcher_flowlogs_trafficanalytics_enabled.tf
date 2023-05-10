resource "azurerm_policy_assignment" "NetworkWatcher_flowlogs_trafficanalytics_enabled" {
  count                = contains(var.policylist, "NetworkWatcher_flowlogs_trafficanalytics_enabled") ? 1 : 0
  name                 = "Network Watcher flow logs should have traffic analytics enabled"
  scope                = var.policyscope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2f080164-9f4d-497e-9db6-416dc9f7b48a"
  description          = "Traffic analytics analyzes Network Watcher network security group flow logs to provide insights into traffic flow in your Azure cloud. It can be used to visualize network activity across your Azure subscriptions and identify hot spots, identify security threats, understand traffic flow patterns, pinpoint network misconfigurations and more."
  display_name         = "Network Watcher flow logs should have traffic analytics enabled"
}