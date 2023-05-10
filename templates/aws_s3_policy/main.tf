#####################################################################################
# S3 Private Policy
#####################################################################################
module "s3_private_policy" {
  source = "./modules/s3_private_policy"

  bucket_name = var.bucket_name
}