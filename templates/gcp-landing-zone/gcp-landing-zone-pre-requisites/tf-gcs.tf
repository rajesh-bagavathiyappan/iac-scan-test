module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> 2.2"

  project_id       = module.project-factory-system-internal.project_id
  names            = ["tfstates"]
  randomize_suffix = true
  prefix           = local.seed_project_id
  versioning = {
    first = true
  }
}
