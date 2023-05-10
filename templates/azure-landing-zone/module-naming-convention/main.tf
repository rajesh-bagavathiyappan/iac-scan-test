resource "random_string" "name" {
  min_numeric = 1
  length      = 4
  special     = false
  lower       = true
  upper       = false
  number      = true
}

locals {
  location_by_short_name = {
    WE   = "West Europe"
    NE   = "North Europe"
    EU   = "East US"
    WU   = "West US"
    CUS  = "Central US"
    EU2  = "East US 2"
    NCUS = "North Central US"
    SCUS = "South Central US"
    WUS2 = "West US 2"
    WUS3 = "West US 3"
  }
  locations_by_name = zipmap(values(local.location_by_short_name), keys(local.location_by_short_name))
  # environment_number = regex(".{3}$", data.azurerm_subscription.this.display_name)
  # environment = upper(regex("(.{3}).{6}$", data.azurerm_subscription.this.display_name)[0])
  names = {
    resource_group          = "RSG"
    storage_account         = "STA"
    virtual_network         = "VNT"
    subnet                  = "SNT"
    virtual_machine_Lnx     = "VMX"
    virtual_machine_Win     = "VMW"
    keyvaut                 = "KVT"
    application_insights    = "AIN"
    azurerm_network_watcher = "ANW"
    log_analytics_workspace = "LAW"
    recovery_services_vault = "RSV"
    api_management          = "APM"
    sql_database            = "SQL"
    sql_server              = "SDB"
  }



  resource_names = {
    resource_group          = format("%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["resource_group"])
    resource_group_sub      = format("%s%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["resource_group"], "LAND")
    virtual_machine_Lnx     = format("%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["virtual_machine_Lnx"])
    virtual_machine_Win     = format("%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["virtual_machine_Win"])
    storage_account         = format("%s%s%s%s%s", replace(replace(var.landing_Zone_short_name, "-",""), "_", ""), lookup(local.locations_by_name, var.location), replace(replace(var.environment_short_name, "-",""), "_", ""), local.names["storage_account"], random_string.name.result)
    virtual_network         = format("%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["virtual_network"])
    subnet                  = format("%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["subnet"])
    keyvaut                 = format("%s%s%s%s%s", replace(var.landing_Zone_short_name, "_", ""), lookup(local.locations_by_name, var.location), replace(var.environment_short_name, "_", ""), local.names["keyvaut"], random_string.name.result)
    application_insights    = format("%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["application_insights"])
    azurerm_network_watcher = format("%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["azurerm_network_watcher"])
    log_analytics_workspace = format("%s%s%s%s%s", replace(var.landing_Zone_short_name, "_", ""), lookup(local.locations_by_name, var.location), replace(var.environment_short_name, "_", ""), local.names["log_analytics_workspace"], random_string.name.result)
    recovery_services_vault = format("%s%s%s%s", replace(replace(var.landing_Zone_short_name, "-",""), "_", ""), lookup(local.locations_by_name, var.location), replace(replace(var.environment_short_name, "-",""), "_", ""), local.names["recovery_services_vault"])
    api_management          = format("%s%s%s%s%s", replace(var.landing_Zone_short_name, "_", ""), lookup(local.locations_by_name, var.location), replace(var.environment_short_name, "_", ""), local.names["api_management"], random_string.name.result)
    sql_database            = format("%s%s%s%s", var.landing_Zone_short_name, lookup(local.locations_by_name, var.location), var.environment_short_name, local.names["sql_database"])
    sql_server              = format("%s%s%s%s%s", replace(var.landing_Zone_short_name, "_", ""), lookup(local.locations_by_name, var.location), replace(var.environment_short_name, "_", ""), local.names["sql_server"], random_string.name.result)
  }
}
