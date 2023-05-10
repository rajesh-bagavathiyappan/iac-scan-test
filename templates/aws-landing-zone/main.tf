module "organization" {
  source                        = "./modules/organizations"
  management_email              = var.management_email
  aws_service_access_principals = var.aws_service_access_principals
  enabled_policy_types          = var.enabled_policy_types

  create_environment_ous = var.create_environment_ous
  create_accounts        = var.create_accounts

  core_ous        = var.core_ous
  environment_ous = var.environment_ous
  custom_ous      = var.custom_ous
  admin_user_arn  = module.iam.management_administrator_arn

  depends_on = [
    module.iam
  ]
}

module "iam" {
  source     = "./modules/IAM"
  admin_user = var.admin_user
}
