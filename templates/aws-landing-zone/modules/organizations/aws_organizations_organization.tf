resource "aws_organizations_organization" "this" {
  aws_service_access_principals = var.aws_service_access_principals

  feature_set = "ALL"

  enabled_policy_types = var.enabled_policy_types
}