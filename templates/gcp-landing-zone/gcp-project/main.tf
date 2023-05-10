provider "google" {
  credentials = "#PROVIDER-CREDENTIAL#"
}

provider "google-beta" {
  credentials = "#PROVIDER-CREDENTIAL#"
}

provider "null" {}

provider "random" {}

terraform {
  required_version = ">= 0.12.6"
  experiments = [module_variable_optional_attrs]
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    google = {
      version = "3.89.0"
    }
    google-beta = {
      version = "3.89.0"
    }
  }
  backend "gcs" {
    credentials = "#BACKEND-CREDENTIAL#"
    bucket      = "#BACKEND-BUCKET#"
    prefix      = "#BACKEND-PREFIX#"
  }
}

//# Get outputs from GCP remote state
//data "terraform_remote_state" "gcp-org" {
//  backend = "gcs"
//  config = {
//    credentials = "#BACKEND-CREDENTIAL#"
//    bucket      = var.org_bucket
//    prefix      = var.org_prefix
//  }
//}

