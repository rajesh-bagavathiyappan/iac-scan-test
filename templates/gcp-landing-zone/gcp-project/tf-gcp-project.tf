locals {
  seed_project_id = var.project_id != "" ? var.project_id : format("%s-%s", var.project_prefix, var.env_name)
}

module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "11.2.2"

  random_project_id       = true
  name                    = local.seed_project_id
  org_id                  = var.org_id
  billing_account         = var.billing_account
  default_service_account = "deprivilege"
  auto_create_network     = false
  # grant_services_security_admin_role
  # shared_vpc         = module.host-project.project_id
  # shared_vpc_subnets = module.vpc.subnets_self_links

  activate_apis = var.activate_apis

  # activate_api_identities = [{
  #   api = "container.googleapis.com"
  #   roles = [
  #     "roles/compute.networkUser",
  #     "roles/container.hostServiceAgentUser",
  #     "roles/container.serviceAgent",
  #   ]
  # }]

  labels = {
    managed_by = "terraform"
  }
}
