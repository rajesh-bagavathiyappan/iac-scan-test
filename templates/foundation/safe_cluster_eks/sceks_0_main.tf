terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket     = "testcmdep-job-states"
    key        = "safe-k8s"
    region     = "us-east-2"
    access_key = "AKIASDPJUEZWODVCWJPY"
    secret_key = "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"
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}
