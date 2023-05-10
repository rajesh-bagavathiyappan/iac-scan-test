## Manage Instance Group with autoscaling

### Authentication with gcp [Prerequisite]
- Download the service account key
- Run `gcloud auth activate-service-account [ACCOUNT] --key-file=KEY_FILE`
- Run `gcloud auth application-default login` in case token got expired.

### How to run
- Run `terraform init` for initlize the terraform plugin.
- Run `terraform apply` for apply the changes.
- Run `terraform destroy` for remove resources.

### Resources Created under this deployment
- VPC
- Subnet
- Instance Template
- Manage regional instance group
- Regional Auto-Scaler
- Https Load balancer
- NAT Gateway (to reach internet)
- Health Check (loadbalancer and autohealing)
- Firewall rules (allow health check)

### Backend Configurations
```
terraform {
  backend "gcs" {
    bucket  = "terraform-state-cloudmatos-demoblog"
    prefix  = "terraform/state"
  }
} 
```

### How to change the configurations
1. open terraform.tfvars file and modify as per your requirements.

