output "states_bucket_name" {
  value       = module.gcs_buckets.bucket.name
  description = "Bucket name for storing states"
}

output "system_project_id" {
  value       = module.project-factory-system-internal.project_id
  description = "System project ID"
}

output "system_project_name" {
  value = module.project-factory-system-internal.project_name
}

output "system_project_number" {
  value = module.project-factory-system-internal.project_number
}


output "terraform_svc_account_email" {
  value       = google_service_account.terraform_service_account.email
  description = "Terraform service account email"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "enabled_apis" {
  description = "Enabled APIs in the project"
  value       = module.project-factory-system-internal.enabled_apis
}

output "subnets_self_links" {
  value       = [for network in module.vpc.subnets : network.self_link]
  description = "The self-links of subnets being created"
}
