//Outputs
output "wp_service_url" {
  value = kubernetes_service.cmdb_wpservice.status[0].load_balancer[0].ingress[0].ip
  depends_on = [
    kubernetes_service.cmdb_wpservice
  ]
}

output "db_host" {
  value = google_sql_database_instance.cmdbwpdbvm.ip_address.0.ip_address

  depends_on = [
    google_sql_database_instance.cmdbwpdbvm
  ]
}

output "database_name" {
  value = var.wpdb

  depends_on = [
    google_sql_database_instance.cmdbwpdbvm
  ]
}

output "db_user_name" {
  value = var.wpdb_user

  depends_on = [
    google_sql_database_instance.cmdbwpdbvm
  ]
}

output "db_user_passwd" {
  value = var.wpdb_userpass

  depends_on = [
    google_sql_database_instance.cmdbwpdbvm
  ]
}
