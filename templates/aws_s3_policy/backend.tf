terraform {
  backend "s3" {
    bucket     = "#BACKEND-BUCKET-NAME#"
    key        = "s3-policy-terraform.tfstate"
    region     = "#BACKEND-REGION#"
    access_key = "#AWS-BACKEND-ACCESS-KEY#"
    secret_key = "#AWS-BACKEND-SECRET-KEY#"
  }
}