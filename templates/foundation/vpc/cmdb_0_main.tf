terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
  backend "gcs" {
    bucket      = "sched_job_states"
    prefix      = "/deployment/foundation/vpc"
    credentials = "cloudmatos-demoblog-904b756a20fd.json"
  }
}

provider "google" {
  credentials = file(var.creds_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}
