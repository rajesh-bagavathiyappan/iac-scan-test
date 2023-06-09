location                         = "East US 2"
rg_offset                        = 0
environment_short_name           = "LZ"
landing_Zone_short_name          = "Dev"
vnet_addressspace                = ["10.0.0.0/16"]
subnet_address_prefixes          = ["10.0.1.0/24"]
subnet_offset                    = 0
keyvault_offset                  = 0
storage_account_tier             = "Standard"
storage_account_replication_type = "LRS"
enable_https_traffic_only        = true
log_retention_in_days            = "30"
sql_server_version               = "12.0"
sqldb_retention_in_days          = "6"
policylist                       = ["Public_access_to_SQL_DB",  "secure_storage_transfer", "storage_VNET_endpoint", "storage_shared_access_key_usage", "APIM_SKU_support_VNET", "APIM_to_use_VNET", "auditLockOnNetworking", "secure_storage_transfer", "SQL_logs_to_workspace", "SQL_server_enable_auditing", "sqlserverdbcpupercent", "TLS_1_2_SQL_DB", "storage_private_link_usage", "storage_shared_access_key_usage", "NIC_PIP_not_allowed", "VNET_flow_log_configure"]
recovery_services_vault_sku      = "Standard"
publisher_name                   = "TechBirds"
publisher_email                  = "techbirds@tech-birds.io"
apim_sku_name                    = "Developer_1"
tags = {
  BillingOwner   = "TechBird"
  BillingProject = "LandingZone"
  BuildingBlock  = "WebServices"
  Environment    = "Development"
  Function       = "Frontend Application"
}
