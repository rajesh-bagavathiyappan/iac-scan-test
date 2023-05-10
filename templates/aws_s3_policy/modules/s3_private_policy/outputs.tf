output "account_public_access_block_info" {
  value = aws_s3_account_public_access_block.block_account
}

output "bucket_public_access_block_info" {
  value = aws_s3_bucket_public_access_block.block_bucket
}

output "bucket_policy" {
  value = aws_s3_bucket_policy.allow_access_from_another_account
}