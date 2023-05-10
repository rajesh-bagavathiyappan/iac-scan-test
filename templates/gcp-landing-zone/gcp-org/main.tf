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
  required_providers {
    null = {
      version = "~> 2.1"
    }
    random = {
      version = "~> 2.1"
    }
    google = {
      version = "3.89.0"
    }
    google-beta = {
      version = "3.89.0"
    }
  }
  backend "gcs" {
    bucket      = "#BACKEND-BUCKET#"
    prefix      = "#BACKEND-PREFIX#"
    credentials = "#BACKEND-CREDENTIAL#"
  }
}
