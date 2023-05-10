org_id = "1001092628418"
billing_account = "01C2E6-D654BB-30E0DC"
project_prefix = "cloudmatos-demo"

domains_to_allow = ["cloudmatos.io"]
region = "us-west1"

org_iam_binding = {
       "roles/resourcemanager.organizationViewer" = [ "user:valentynk@cloudmatos.io"],
       "roles/resourcemanager.projectDeleter" = ["user:valentynk@cloudmatos.io"]
}