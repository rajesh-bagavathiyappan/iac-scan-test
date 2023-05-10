
# output "policy-attachments" {
#   value = module.organization.policy_attachments
# }

output "core_ous" {
  value = module.organization.core_ous
}

output "custom_ous" {
  value = module.organization.custom_ous
}

output "policies" {
  value = module.organization.policies
}

output "accounts" {
  value = module.organization.accounts
}
