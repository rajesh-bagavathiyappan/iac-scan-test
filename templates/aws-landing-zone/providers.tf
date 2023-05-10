terraform {
  required_version = ">= 0.12.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.23"
    }
  }
  backend "s3" {
    # bucket = "s3-tf-bucket"
    key    = "terraform.tfstate"
    bucket     = "#BACKEND-BUCKET-NAME#"
    region     = "#BACKEND-REGION#"
    access_key = "#AWS-BACKEND-ACCESS-KEY#"
    secret_key = "#AWS-BACKEND-SECRET-KEY#"
  }
}

provider "aws" {
  region     = "#PROVIDER-REGION#"
  access_key = "#AWS-PROVIDER-ACCESS-KEY#"
  secret_key = "#AWS-PROVIDER-SECRET-KEY#"
}
