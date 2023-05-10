// Creating VPC and subnet
resource "google_compute_network" "cmdbvpc" {
  name                    = var.vpc
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "cmdbsubnet" {
  name          = var.subnet
  region        = var.region
  network       = google_compute_network.cmdbvpc.name
  ip_cidr_range = "10.0.1.0/24"
}

//Creating Firewall for VPC Network
resource "google_compute_firewall" "cmdbfirewall" {
  name    = var.firewall
  network = google_compute_network.cmdbvpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "3306"]
  }

  source_tags = ["wp", "wordpress", "db", "databases"]

  depends_on = [
    google_compute_network.cmdbvpc
  ]
}
