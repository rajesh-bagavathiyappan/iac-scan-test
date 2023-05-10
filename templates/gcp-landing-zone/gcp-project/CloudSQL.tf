locals {
  maintenance_window_day = 5
  maintenance_window_hour = 12
  maintenance_window_update_track = "stable"
  random_instance_name = true
  availability_type = "ZONAL"
  deletion_protection = false

  backup_configuration = {
    enabled                        = true
    start_time                     = "20:55"
    point_in_time_recovery_enabled = false
    retained_backups               = 365
    retention_unit                 = "COUNT"
  }

  ip_configuration = {
    ipv4_enabled       = true
    require_ssl        = true
    private_network    = null
    allocated_ip_range = null
    authorized_networks = [
      {
        name  = "sample-gcp-health-checkers-range"
        value = "130.211.0.0/28"
      },
    ]
  }

  db_name      = "default_db"

  pg_db_charset   = "UTF8"
  pg_db_collation = "en_US.UTF8"

  mysql_db_charset   = "UTF8"
  mysql_db_collation = "utf8_general_ci"

  user_name     = "default_u"
  user_password = "foobar"

  disk_type = "PD_SSD"
  disk_size = 10
  disk_autoresize = true
}

module "pg" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/postgresql"
  version = "8.0.0"
  depends_on = [module.kms-pg-1]

  #for_each = var.shared_vpc != true ? var.pgsql : {}
  for_each = var.pgsql != null ? var.pgsql : {}



  project_id                      = module.project-factory.project_id
  name                            = each.value.name
  region                          = each.value.region
  database_version                = each.value.database_version
  tier                            = each.value.tier
  zone                            = each.value.zone

  disk_type                       = coalesce(each.value.disk_type, local.disk_type )
  disk_size                       = coalesce(each.value.disk_size, local.disk_size )
  disk_autoresize                 = coalesce(each.value.disk_autoresize, local.disk_autoresize )

  random_instance_name            = coalesce(each.value.random_instance_name, local.random_instance_name )
  availability_type               = coalesce(each.value.availability_type, local.availability_type )
  maintenance_window_day          = coalesce(each.value.maintenance_window_day, local.maintenance_window_day )
  maintenance_window_hour         = coalesce(each.value.maintenance_window_hour, local.maintenance_window_hour )
  maintenance_window_update_track = coalesce(each.value.maintenance_window_update_track, local.maintenance_window_update_track )
  deletion_protection             = coalesce(each.value.deletion_protection, local.deletion_protection )

  database_flags = [{ name = "autovacuum", value = "off" }]

  user_labels = {
    managed_by = "terraform"
    env_name   = var.env_name
  }

  ip_configuration      = {
    ipv4_enabled        = coalesce(each.value.ip_configuration.ipv4_enabled, local.ip_configuration.ipv4_enabled)
    require_ssl         = coalesce(each.value.ip_configuration.require_ssl, local.ip_configuration.require_ssl)
    private_network     = each.value.ip_configuration.private_network
    allocated_ip_range  = each.value.ip_configuration.allocated_ip_range
    authorized_networks = coalesce(each.value.ip_configuration.authorized_networks, local.ip_configuration.authorized_networks)
  }

  backup_configuration = {
    enabled                        = coalesce(each.value.backup_configuration.enabled, local.backup_configuration.enabled)
    start_time                     = coalesce(each.value.backup_configuration.start_time, local.backup_configuration.start_time)
    location                       = each.value.backup_configuration.location
    point_in_time_recovery_enabled = coalesce(each.value.backup_configuration.point_in_time_recovery_enabled, local.backup_configuration.point_in_time_recovery_enabled)
    transaction_log_retention_days = each.value.backup_configuration.transaction_log_retention_days
    retained_backups               = coalesce(each.value.backup_configuration.retained_backups, local.backup_configuration.retained_backups)
    retention_unit                 = coalesce(each.value.backup_configuration.retention_unit, local.backup_configuration.retention_unit)
  }

  db_name      = coalesce(each.value.db_name, local.db_name)
  db_charset   = coalesce(each.value.db_charset, local.pg_db_charset)
  db_collation = coalesce(each.value.db_collation, local.pg_db_collation)

  user_name     = coalesce(each.value.user_name, local.user_name)
  user_password = coalesce(each.value.user_password, local.user_password)

  encryption_key_name = "${module.kms-pg-1.keyring}/cryptoKeys/pg"

  create_timeout = var.create_timeout
  update_timeout = var.update_timeout
  delete_timeout = var.delete_timeout

}

module "mysql" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "8.0.0"

  for_each = var.mysql != null ? var.mysql : {}



  project_id                      = module.project-factory.project_id
  name                            = each.value.name
  region                          = each.value.region
  database_version                = each.value.database_version
  tier                            = each.value.tier
  zone                            = each.value.zone

  disk_type                       = coalesce(each.value.disk_type, local.disk_type )
  disk_size                       = coalesce(each.value.disk_size, local.disk_size )
  disk_autoresize                 = coalesce(each.value.disk_autoresize, local.disk_autoresize )

  random_instance_name            = coalesce(each.value.random_instance_name, local.random_instance_name )
  availability_type               = coalesce(each.value.availability_type, local.availability_type )
  maintenance_window_day          = coalesce(each.value.maintenance_window_day, local.maintenance_window_day )
  maintenance_window_hour         = coalesce(each.value.maintenance_window_hour, local.maintenance_window_hour )
  maintenance_window_update_track = coalesce(each.value.maintenance_window_update_track, local.maintenance_window_update_track )
  deletion_protection             = coalesce(each.value.deletion_protection, local.deletion_protection )

  #database_flags = [{ name = "autovacuum", value = "off" }]

  user_labels = {
    managed_by = "terraform"
    env_name   = var.env_name
  }

  ip_configuration      = {
    ipv4_enabled        = coalesce(each.value.ip_configuration.ipv4_enabled, local.ip_configuration.ipv4_enabled)
    require_ssl         = coalesce(each.value.ip_configuration.require_ssl, local.ip_configuration.require_ssl)
    private_network     = each.value.ip_configuration.private_network
    allocated_ip_range  = each.value.ip_configuration.allocated_ip_range
    authorized_networks = coalesce(each.value.ip_configuration.authorized_networks, local.ip_configuration.authorized_networks)
  }

  backup_configuration = {
    enabled                        = coalesce(each.value.backup_configuration.enabled, local.backup_configuration.enabled)
    start_time                     = coalesce(each.value.backup_configuration.start_time, local.backup_configuration.start_time)
    binary_log_enabled             = coalesce(each.value.backup_configuration.binary_log_enabled, false)
    location                       = each.value.backup_configuration.location
    transaction_log_retention_days = each.value.backup_configuration.transaction_log_retention_days
    retained_backups               = coalesce(each.value.backup_configuration.retained_backups, local.backup_configuration.retained_backups)
    retention_unit                 = coalesce(each.value.backup_configuration.retention_unit, local.backup_configuration.retention_unit)
  }

  #read_replica_name_suffix = coalesce(each.value.read_replica_name_suffix, "")
  read_replicas            = coalesce(each.value.read_replicas, [])

  db_name      = coalesce(each.value.db_name, local.db_name)
  db_charset   = coalesce(each.value.db_charset, local.mysql_db_charset)
  db_collation = coalesce(each.value.db_collation, local.mysql_db_collation)

  user_name     = coalesce(each.value.user_name, local.user_name)
  user_password = coalesce(each.value.user_password, local.user_password)

  create_timeout = var.create_timeout
  update_timeout = var.update_timeout
  delete_timeout = var.delete_timeout

}
