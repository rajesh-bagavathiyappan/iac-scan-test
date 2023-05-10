locals {
  seed_project_id = var.project_id != "" ? var.project_id : format("%s-%s", var.project_prefix, "sys-int")
}

module "project-factory-system-internal" {
  source  = "terraform-google-modules/project-factory/google"
  version = "11.2.2"

  random_project_id       = true
  name                    = local.seed_project_id
  org_id                  = var.org_id
  billing_account         = var.billing_account
  lien                    = true
  default_service_account = "deprivilege"
  auto_create_network     = false

  activate_apis = var.activate_apis

  activate_api_identities = [{
    api = "container.googleapis.com"
    roles = [
      "roles/container.serviceAgent",
      "roles/container.hostServiceAgentUser",
      "roles/compute.networkUser",
      "roles/iam.securityAdmin",
      "roles/composer.sharedVpcAgent",
    ]
    },
    {
    api = "compute.googleapis.com"
    roles = [
      "roles/compute.serviceAgent",
      "roles/compute.networkUser",
      "roles/composer.sharedVpcAgent",
    ]
  }
  ]

  labels = {
    managed_by = "terraform"
  }
}

