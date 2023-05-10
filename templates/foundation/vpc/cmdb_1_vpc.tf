// Random random uuid
resource "random_uuid" "db_instance_suffix" {}

// Creating VPC and subnet
resource "google_compute_network" "basevpc" {
  name                    = "${var.vpc}${random_uuid.db_instance_suffix.result}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "basesubnet" {
  name          = "${var.subnet}${random_uuid.db_instance_suffix.result}"
  region        = var.region
  network       = google_compute_network.basevpc.name
  ip_cidr_range = "10.0.1.0/24"

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.0.2.0/24"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.0.3.0/24"
  }
}

//Creating Firewall for VPC Network
resource "google_compute_firewall" "basefirewall" {
  name    = "${var.firewall}${random_uuid.db_instance_suffix.result}"
  network = google_compute_network.basevpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "8443", "22"]
  }

  source_tags = ["private", "vpc", "subnet", "httpd", "https"]

  depends_on = [
    google_compute_network.basevpc
  ]
}
