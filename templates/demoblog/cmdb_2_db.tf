//Configuring SQL Database instance
resource "google_sql_database_instance" "cmdbwpdbvm" {
  name                = var.wpdbvm
  database_version    = "MYSQL_8_0"
  region              = var.region
  deletion_protection = "false"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      ipv4_enabled = true

      authorized_networks {
        name  = "sqlnet"
        value = "0.0.0.0/0"
      }
    }
  }

  depends_on = [
    google_compute_subnetwork.cmdbsubnet
  ]
}

//Creating SQL Database
resource "google_sql_database" "cmdbwpdb" {
  name     = var.wpdb
  instance = google_sql_database_instance.cmdbwpdbvm.name

  depends_on = [
    google_sql_database_instance.cmdbwpdbvm
  ]
}

//Creating SQL Database User
resource "google_sql_user" "cmdbwpdbuser" {
  name     = var.wpdb_user
  instance = google_sql_database_instance.cmdbwpdbvm.name
  password = var.wpdb_userpass

  depends_on = [
    google_sql_database_instance.cmdbwpdbvm
  ]
}
