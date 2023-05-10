output "Project_info" {
  value = yamlencode({
    enabled_apis = module.project-factory.enabled_apis
    project_id   = module.project-factory.project_id
    project_name = module.project-factory.project_name
  })
  description = "Global info about created project"
}

# output "quota_overrides" {
#   description = "Overided quotas"
#   value       = module.project_quota_manager.quota_overrides
# }

output "ipaddresses" {
  description = "List of address values managed by this module"
  value = toset([
    for ipnames in module.address : ipnames.addresses
  ])
}
