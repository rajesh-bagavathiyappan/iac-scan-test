# locals {
#   service_account_email = "serviceAccount:${outputs.terraform_svc_account_email}"
# }

module "organization_iam_binding" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  organizations = [var.org_id]
  #mode          = "authoritative"

  bindings = var.org_iam_binding
}


resource "google_service_account" "terraform_service_account" {
  account_id   = "terraform-sa"
  display_name = "Service Account for terraform"
  project      = module.project-factory-system-internal.project_id
}


module "terraform_svc_account_organization_iam_binding" {
  source        = "terraform-google-modules/iam/google//modules/organizations_iam"
  organizations = [var.org_id]

  bindings = {
    "roles/billing.admin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/assuredworkloads.admin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/compute.xpnAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/resourcemanager.folderAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/resourcemanager.organizationAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/container.hostServiceAgentUser" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/orgpolicy.policyAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/iam.organizationRoleAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/resourcemanager.projectCreator" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/securitycenter.admin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/billing.projectManager" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/storage.admin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/storage.objectAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/compute.networkAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/iam.serviceAccountAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/resourcemanager.projectIamAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/iam.serviceAccountUser" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/container.clusterAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/compute.securityAdmin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ],
    "roles/compute.admin" = [
      "serviceAccount:${google_service_account.terraform_service_account.email}"
    ]
  }
}
