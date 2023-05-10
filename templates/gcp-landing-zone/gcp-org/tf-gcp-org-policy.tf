# module "org-policy" {
#   source            = "terraform-google-modules/org-policy/google"
#   version           = "~> 3.0.2"

#   constraint        = "constraints/serviceuser.services"
#   policy_type       = "list"
#   organization_id   = var.org_id
#   enforce           = true
#   #exclude_folders   = ["folders/folder-1-id", "folders/folder-2-id"]
#   #exclude_projects  = ["project3", "project4"]
# }

module "domain-restricted-sharing" {
  source           = "github.com/terraform-google-modules/terraform-google-org-policy/modules/domain_restricted_sharing"
  policy_for       = "organization"
  organization_id  = var.org_id
  domains_to_allow = var.domains_to_allow
}

module "skip-default-network" {
  source          = "github.com/terraform-google-modules/terraform-google-org-policy/modules/skip_default_network"
  policy_for      = "organization"
  organization_id = var.org_id
}
