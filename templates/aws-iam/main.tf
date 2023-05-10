#####################################################################################
# IAM users 
#####################################################################################
module "iam_users" {
  source   = "./modules/iam-users"
  for_each = var.users
  name     = each.key

  create_iam_user_login_profile = each.value.create_iam_user_login_profile
  create_iam_access_key         = each.value.create_iam_access_key
}

#####################################################################################
# IAM group for users and associated policies 
#####################################################################################

module "iam_group_with_custom_policies_looptest" {
  source   = "./modules/iam-group-with-policies"
  for_each = var.user_groups
  name     = each.key

  group_users = each.value.user_list

  custom_group_policies = [
    {
      name   = each.value.policy_name
      policy = jsonencode(lookup(var.actions, "${each.value.policy_ref}"))
    },
  ]
}
