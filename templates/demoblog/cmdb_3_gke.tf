//Creating Container Cluster
resource "google_container_cluster" "cmdbgke_cluster" {
  name                     = var.gke
  description              = var.gke
  project                  = var.project
  location                 = var.region
  network                  = google_compute_network.cmdbvpc.name
  subnetwork               = google_compute_subnetwork.cmdbsubnet.name
  remove_default_node_pool = true
  initial_node_count       = 1

  depends_on = [
    google_compute_subnetwork.cmdbsubnet
  ]
}

//Creating Node Pool For Container Cluster
resource "google_container_node_pool" "cmdbgke_nodepool" {
  name       = var.gkenodepool
  project    = var.project
  location   = var.region
  cluster    = google_container_cluster.cmdbgke_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-micro"
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  depends_on = [
    google_container_cluster.cmdbgke_cluster
  ]
}
