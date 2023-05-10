output "policies" {
  value = aws_organizations_policy.this
}

output "core_ous" {
  value = aws_organizations_organizational_unit.core_ous
}

output "custom_ous" {
  value = aws_organizations_organizational_unit.custom_ous
}

# output "policy_attachments" {
#   value = aws_organizations_policy_attachment.this
# }

output "accounts" {
  # value = local.accounts
  value = aws_organizations_account.account.*.arn
}

