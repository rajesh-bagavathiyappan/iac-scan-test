org_id = ""
billing_account = ""
project_prefix = "cloudmatos"

domains_to_allow = ["cloudmatos.io"]
region = "us-west1"

org_iam_binding = {
       "roles/resourcemanager.organizationViewer" = [ "user:valentynk@cloudmatos.io"],
       "roles/resourcemanager.projectDeleter" = ["user:valentynk@cloudmatos.io"]
}
