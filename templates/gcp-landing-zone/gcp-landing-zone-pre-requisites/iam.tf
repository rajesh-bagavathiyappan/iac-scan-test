resource "google_service_account" "terraform_service_account" {
  depends_on    = [ module.project-factory-system-internal ]

  account_id   = "terraform-sa"
  display_name = "Service Account for terraform"
  project      = module.project-factory-system-internal.project_id
}


resource "google_organization_iam_member" "binding" {
  depends_on    = [module.project-factory-system-internal, google_service_account.terraform_service_account]

  for_each = toset(var.svc-permissions)
  org_id = var.org_id
  role    = each.value

  member = "serviceAccount:${google_service_account.terraform_service_account.email}"
}

