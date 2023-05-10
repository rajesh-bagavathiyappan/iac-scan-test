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
