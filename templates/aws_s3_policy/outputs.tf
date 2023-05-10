output "account_infro" {
  value = module.s3_private_policy.account_public_access_block_info
}

output "bucket_info" {
  value = module.s3_private_policy.bucket_public_access_block_info
}

output "bucket_policy_info" {
  value = module.s3_private_policy.bucket_policy
}