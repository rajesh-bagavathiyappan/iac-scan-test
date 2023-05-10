module "naming_module" {
  source                  = "./module-naming-convention"
  location                = var.location
  environment_short_name  = var.environment_short_name
  landing_Zone_short_name = var.landing_Zone_short_name
}

module "rg01" {
  source    = "./module-rg"
  rg_offset = var.rg_offset
  rg_name   = module.naming_module.resource_names.resource_group_sub
  location  = var.location
  tags      = var.tags
}

module "vnet01" {
  depends_on = [
    module.monitor
  ]
  source            = "./module-vnet"
  rg_name           = module.rg01.ouput_rg_name
  location          = module.rg01.ouput_rg_location
  vnet_name         = module.naming_module.resource_names.virtual_network
  vnet_addressspace = var.vnet_addressspace
  tags              = var.tags
}

module "subnet" {
  source                  = "./module-subnet"
  rg_name                 = module.rg01.ouput_rg_name
  location                = module.rg01.ouput_rg_location
  vnet_name               = module.vnet01.output_vnet_name
  subnet_name             = module.naming_module.resource_names.subnet
  subnet_offset           = var.subnet_offset
  subnet_address_prefixes = var.subnet_address_prefixes
  tags                    = var.tags
}

module "kv01" {
  source          = "./module-kv"
  kv_name         = module.naming_module.resource_names.keyvaut
  keyvault_offset = var.keyvault_offset
  rg_name         = module.rg01.ouput_rg_name
  location        = module.rg01.ouput_rg_location
  tags            = var.tags
}

module "sta01" {
  source                           = "./module-storage"
  storage_account_name             = module.naming_module.resource_names.storage_account
  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
  enable_https_traffic_only        = var.enable_https_traffic_only
  rg_name                          = module.rg01.ouput_rg_name
  location                         = module.rg01.ouput_rg_location
  tags                             = var.tags
}

module "monitor" {
  source                       = "./module-monitor"
  rg_name                      = module.rg01.ouput_rg_name
  location                     = module.rg01.ouput_rg_location
  #network_watcher_name         = module.naming_module.resource_names.azurerm_network_watcher
  #flowlog_nsg_id               = module.subnet.output_nsg_id
  #flowlog_storage_id           = module.sta01.storage_account_id
  log_analytics_workspace_name = module.naming_module.resource_names.log_analytics_workspace
  log_retention_in_days        = var.log_retention_in_days
  tags                         = var.tags
}

module "app-insights" {
  source            = "./module-app-insights"
  rg_name           = module.rg01.ouput_rg_name
  location          = module.rg01.ouput_rg_location
  app_insights_name = module.naming_module.resource_names.application_insights
  tags              = var.tags
}

module "rsv" {
  source                       = "./module-rsv"
  rg_name                      = module.rg01.ouput_rg_name
  location                     = module.rg01.ouput_rg_location
  recovery_services_vault_name = module.naming_module.resource_names.recovery_services_vault
  recovery_services_vault_sku  = "Standard"
  tags                         = var.tags
}

module "apim" {
  source          = "./module-apim"
  rg_name         = module.rg01.ouput_rg_name
  location        = module.rg01.ouput_rg_location
  apim_name       = module.naming_module.resource_names.api_management
  publisher_name  = "TestPublisher"
  publisher_email = "test@publisheremail.com"
  apim_sku_name   = "Developer_1"
  apim_subnet_id  = module.subnet.output_subnet_id
  tags            = var.tags
}

module "sqlserver" {
  source                        = "./module-sql-server"
  rg_name                       = module.rg01.ouput_rg_name
  location                      = module.rg01.ouput_rg_location
  sql_server_name               = module.naming_module.resource_names.sql_server
  sql_server_version            = var.sql_server_version
  keyvaut_id                    = module.kv01.output-kv-id
  storage_primary_blob_endpoint = module.sta01.storage_primary_blob_endpoint
  storage_primary_access_key    = module.sta01.storage_primary_access_key
  sql_retention_in_days         = var.sqldb_retention_in_days
  tags                          = var.tags
}

module "sqldb" {
  source            = "./module-sql-db"
  rg_name           = module.rg01.ouput_rg_name
  location          = module.rg01.ouput_rg_location
  sql_database_name = module.naming_module.resource_names.sql_database
  sql_server_name   = module.sqlserver.sql_server_name
  tags              = var.tags
}

module "policy" {
  source                             = "./module-policy"
  policylist                         = var.policylist
  policyscope                        = data.azurerm_subscription.current.id
  SQL_resourceName                   = module.sqldb.SQL_resourceName
  SQL_resourceId                     = module.sqldb.SQL_resourceId
  location                           = var.location
  azure_monitor_action_group_name    = module.monitor.azure_monitor_action_group_name
  azure_monitor_action_group_rg_name = module.monitor.azure_monitor_action_group_rg_name
  logAnalyticsWorkspaceId            = module.monitor.azure_monitor_workspace_id
}
