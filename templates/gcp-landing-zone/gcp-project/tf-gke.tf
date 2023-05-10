 module "gke" {
  source             = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version            = "18.0.0"
  depends_on         = [module.vpc]

  for_each = var.shared_vpc != true ? var.gke : {}

  kubernetes_version         = "latest"
  project_id                 = module.project-factory.project_id
  name                       = each.value.name
  region                     = each.value.region
  network                    = module.vpc[0].network_name
  subnetwork                 = each.value.subnetwork
  ip_range_pods              = each.value.ip_range_pods
  ip_range_services          = each.value.ip_range_services
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  enable_private_endpoint    = false
  enable_private_nodes       = each.value.enable_private_nodes
  network_policy             = false
  regional                   = true
  create_service_account     = false
  master_ipv4_cidr_block     = each.value.master_ipv4_cidr_block

  remove_default_node_pool = true

  node_pools = each.value.node_pools

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  cluster_resource_labels = {
    managed_by = "terraform"
  }

  node_pools_labels = {
    all = { managed_by = "terraform" }
  }

  node_pools_metadata = {
    all = {}
  }

  node_pools_taints = {
    all = []
  }

  node_pools_tags = {
    all = []
  }
}

resource "google_project_iam_member" "container-serviceagent_01" {
  count   = var.shared_vpc ? 1 : 0
  project = var.shared_vpc_project_id
  role    = "roles/container.serviceAgent"

  member = "serviceAccount:${format("service-%s@container-engine-robot.iam.gserviceaccount.com", module.project-factory.project_number)}"
}

resource "google_project_iam_member" "compute-securityadmin_01" {
  # checkov:skip=CKV_GCP_49: Needed for shared vpc
  count   = var.shared_vpc ? 1 : 0
  project = var.shared_vpc_project_id
  role    = "roles/iam.securityAdmin"

  member = "serviceAccount:${format("service-%s@container-engine-robot.iam.gserviceaccount.com", module.project-factory.project_number)}"
}

resource "google_project_iam_member" "container-serviceagent_02" {
  count   = var.shared_vpc ? 1 : 0
  project = var.shared_vpc_project_id
  role    = "roles/container.serviceAgent"

  member = "serviceAccount:${format("%s@cloudservices.gserviceaccount.com", module.project-factory.project_number)}"
}

resource "google_project_iam_member" "compute-securityadmin_02" {
	# checkov:skip=CKV_GCP_49: Needed for shared vpc
  count   = var.shared_vpc ? 1 : 0
  project = var.shared_vpc_project_id
  role    = "roles/iam.securityAdmin"

  member = "serviceAccount:${format("%s@cloudservices.gserviceaccount.com", module.project-factory.project_number)}"
}

 module "gke_shared" {
  source             = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version            = "18.0.0"
  depends_on = [google_project_iam_member.compute-securityadmin_01, google_project_iam_member.container-serviceagent_01, google_project_iam_member.compute-securityadmin_02, google_project_iam_member.container-serviceagent_02]
  for_each = var.shared_vpc != false ? var.gke : {}

  kubernetes_version         = "latest"
  project_id                 = module.project-factory.project_id
  name                       = each.value.name
  region                     = each.value.region
  network                    = var.shared_vpc_network_name
  network_project_id         = var.shared_vpc_project_id
  subnetwork                 = each.value.subnetwork
  ip_range_pods              = each.value.ip_range_pods
  ip_range_services          = each.value.ip_range_services
  http_load_balancing        = false
  horizontal_pod_autoscaling = true
  enable_private_endpoint    = false
  enable_private_nodes       = each.value.enable_private_nodes
  network_policy             = false
  regional                   = true
  create_service_account     = false
  master_ipv4_cidr_block     = each.value.master_ipv4_cidr_block

  remove_default_node_pool = true

  node_pools = each.value.node_pools

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
  cluster_resource_labels = {
    managed_by = "terraform"
  }

  node_pools_labels = {
    all = { managed_by = "terraform" }
  }

  node_pools_metadata = {
    all = {}
  }

  node_pools_taints = {
    all = []
  }

  node_pools_tags = {
    all = []
  }
}



