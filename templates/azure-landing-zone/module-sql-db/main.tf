resource "azurerm_sql_database" "sqldb" {
  name                = var.sql_database_name
  resource_group_name = var.rg_name
  location            = var.location
  server_name         = var.sql_server_name
  tags                = var.tags
  edition             = var.edition
  requested_service_objective_name   = var.requested_service_objective_name   
}
