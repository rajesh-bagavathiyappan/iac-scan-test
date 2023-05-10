application_name = "test-app"
region           = "us-west1"
subnet_range     = "10.0.1.0/24"
machine_type     = "e2-small"
source_image     = "projects/cloudmatos-demoblog/global/images/custom-nginx-image"
vpc_network      = "cmdbvpc"
subnet_name      = "projects/cloudmatos-demoblog/regions/us-west1/subnetworks/cmdbsubnet"

autoscaling_policy = {
  max_replicas    = 2
  min_replicas    = 1
  cooldown_period = 60
  cpu_utilization = 0.8
}

# nat_config = {

# }