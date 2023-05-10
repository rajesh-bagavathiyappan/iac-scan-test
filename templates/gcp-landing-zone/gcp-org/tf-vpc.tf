module "vpc" {
  source = "terraform-google-modules/network/google"
  # version = "~> 3.0"

  project_id              = module.project-factory-system-internal.project_id
  network_name            = "${var.project_prefix}-default-vpc"
  shared_vpc_host         = true
  routing_mode            = var.routing_mode
  subnets                 = var.subnets
  routes                  = var.routes
  secondary_ranges        = var.secondary_ranges
}

