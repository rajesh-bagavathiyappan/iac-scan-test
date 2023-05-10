terraform {
  backend "gcs" {
    bucket = "terraform-state-cloudmatos-demoblog"
    prefix = "terraform/state"
  }
}