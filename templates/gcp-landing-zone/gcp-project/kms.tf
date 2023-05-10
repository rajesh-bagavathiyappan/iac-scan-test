module "kms-pg-1" {
  source     = "terraform-google-modules/kms/google"
  version    = "~> 1.2"

  project_id = module.project-factory.project_id
  location   = "us-west1"

  #keyring    = var.keyring
  #keys       = var.keys

  keyring            = "pg-key-1"
  keys               = ["pg"]

  prevent_destroy = false

  set_owners_for     = ["pg"]
  owners = [
    "serviceAccount:terraform-sa@vktest-sys-int-02b7.iam.gserviceaccount.com",
  ]
}

output "keyring" {
  value       = module.kms-pg-1.keyring
}
output "keys" {
  value       = module.kms-pg-1.keys
}
