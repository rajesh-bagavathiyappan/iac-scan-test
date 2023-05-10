module "project-iam-bindings" {
  source   = "terraform-google-modules/iam/google//modules/projects_iam"
  projects = [module.project-factory.project_id]
  mode     = "additive"

  bindings = var.project_iam_binding
}
