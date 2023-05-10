provider "google" {
}

provider "google-beta" {
}

provider "null" {}

provider "random" {}

terraform {
  required_version = ">= 1.0"
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
}
