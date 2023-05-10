resource "google_compute_shared_vpc_service_project" "service1" {
  count   = var.shared_vpc ? 1 : 0
  host_project    = var.shared_vpc_project_id
  service_project = module.project-factory.project_id
}

module "vpc" {
  count   = var.shared_vpc ? 0 : 1
  source = "terraform-google-modules/network/google"
  version = "4.0.0"

  project_id              = module.project-factory.project_id
  network_name            = "${var.project_prefix}-${var.env_name}-vpc"
  routing_mode            = var.routing_mode
  subnets                 = var.subnets
  routes                  = var.routes
  secondary_ranges        = var.secondary_ranges

}

resource "google_compute_router" "router" {
  for_each = var.shared_vpc != true ? var.cloud_nat : {}
    project = module.project-factory.project_id
    network = module.vpc[0].network_self_link
    name    = each.value.router_name
    region  = each.value.region
}


module "cloud-nat" {
  source     = "terraform-google-modules/cloud-nat/google"
  version    = "2.0.0"
  depends_on = [module.vpc]
  for_each = var.shared_vpc != true ? var.cloud_nat : {}
    project_id = module.project-factory.project_id
    region     = each.value.region
    router     = each.value.router_name
}

module "address" {
  source       = "terraform-google-modules/address/google"
  version      = "3.0.0"
  for_each = var.shared_vpc != true ? var.cloud_nat : {}
  project_id   = module.project-factory.project_id
  region       = each.value.region
  address_type = "EXTERNAL"
  names = each.value.ip_count
}
