#resource "azurerm_network_watcher" "nw" {
#  name                = var.network_watcher_name
#  location            = lower(var.location)
#  resource_group_name = var.rg_name
#  tags                = var.tags
#}
#
#resource "azurerm_network_watcher_flow_log" "flowlog" {
#  network_watcher_name = azurerm_network_watcher.nw.name
#  resource_group_name  = var.rg_name
#  name = "${var.network_watcher_name}-flow-log"
#  network_security_group_id = var.flowlog_nsg_id
#  storage_account_id        = var.flowlog_storage_id
#  enabled                   = true
#
#  retention_policy {
#    enabled = true
#    days    = 7
#  }
#
#  traffic_analytics {
#    enabled               = true
#    workspace_id          = azurerm_log_analytics_workspace.law.workspace_id
#    workspace_region      = azurerm_log_analytics_workspace.law.location
#    workspace_resource_id = azurerm_log_analytics_workspace.law.id
#    interval_in_minutes   = 10
#  }
#  tags = var.tags
#}
