output "azure_monitor_action_group_name" {
  value = azurerm_monitor_action_group.actiongroup01.name
}

output "azure_monitor_action_group_rg_name" {
  value = azurerm_monitor_action_group.actiongroup01.resource_group_name
}

output "azure_monitor_workspace_id" {
  value = azurerm_log_analytics_workspace.law.id
}