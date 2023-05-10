##################################################
##### create new vpc
##################################################
resource "google_compute_network" "default" {
  name                    = "${var.application_name}-lb-network"
  provider                = google-beta
  auto_create_subnetworks = false
}

##################################################
##### network subnet
##################################################
resource "google_compute_subnetwork" "default" {
  name          = "${var.application_name}-lb-subnet"
  provider      = google-beta
  ip_cidr_range = var.subnet_range
  region        = var.region
  network       = google_compute_network.default.id
}

##################################################
##### create instance template
##################################################
resource "google_compute_instance_template" "default" {
  name_prefix  = "${var.application_name}-mig-template"
  provider     = google-beta
  machine_type = var.machine_type
  tags         = ["${var.application_name}-allow-health-check"]

  network_interface {
    network    = var.vpc_network
    subnetwork = var.subnet_name
  }
  disk {
    source_image = var.source_image
    auto_delete  = true
    boot         = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

##################################################
##### Reserve Static IP for LB
##################################################
resource "google_compute_global_address" "lb-address" {
  provider = google-beta
  name     = "${var.application_name}-lb-static-ip"
}

##################################################
###### forwarding rule
##################################################
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.application_name}-lb-forwarding-rule"
  provider              = google-beta
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.lb-address.id
}

##################################################
###### http proxy
##################################################
resource "google_compute_target_http_proxy" "default" {
  name     = "${var.application_name}-lb-target-http-proxy"
  provider = google-beta
  url_map  = google_compute_url_map.default.id
}

##################################################
###### URL Map
##################################################
resource "google_compute_url_map" "default" {
  name            = "${var.application_name}-lb-url-map"
  provider        = google-beta
  default_service = google_compute_backend_service.default.id
}

##################################################
###### backend service
##################################################
resource "google_compute_backend_service" "default" {
  name                  = "${var.application_name}-lb-backend-service"
  provider              = google-beta
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  enable_cdn            = true
  health_checks         = [google_compute_health_check.default.id]
  backend {
    group           = google_compute_region_instance_group_manager.default.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

##################################################
###### health check for https load balancer
##################################################
resource "google_compute_health_check" "default" {
  name     = "${var.application_name}-lb-hc"
  provider = google-beta
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}

##################################################
###### health check mig auto-healing
##################################################
resource "google_compute_health_check" "autohealing" {
  name                = "${var.application_name}-autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}

##################################################
###### Managed regional instance group
##################################################
resource "google_compute_region_instance_group_manager" "default" {
  name     = "${var.application_name}-lb--regional-mig1"
  provider = google-beta
  region   = var.region
  named_port {
    name = "http"
    port = 80
  }
  version {
    instance_template = google_compute_instance_template.default.id
    name              = "primary"
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 60
  }

  base_instance_name = var.application_name
  target_size        = 2
}

##################################################
###### Managed regional instance group auto scaler configuration
##################################################
resource "google_compute_region_autoscaler" "regional-mig-autoscaler" {
  name   = "${var.application_name}-regional-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.default.id

  autoscaling_policy {
    max_replicas    = var.autoscaling_policy.max_replicas
    min_replicas    = var.autoscaling_policy.min_replicas
    cooldown_period = var.autoscaling_policy.cooldown_period

    cpu_utilization {
      target = var.autoscaling_policy.cpu_utilization
    }
  }
}

##################################################
###### allow access from health check ranges
##################################################
resource "google_compute_firewall" "default" {
  name          = "${var.application_name}-lb-fw-allow-hc"
  provider      = google-beta
  direction     = "INGRESS"
  network       = var.vpc_network
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "0.0.0.0/0"]
  allow {
    protocol = "tcp"
  }
  target_tags = ["${var.application_name}-allow-health-check"]
}

##################################################
###### router for NAT gateway
##################################################
resource "google_compute_router" "router" {
  name    = "${var.application_name}-router"
  region  = google_compute_subnetwork.default.region
  network = google_compute_network.default.id

  bgp {
    asn = 64514
  }
}

##################################################
###### cloud NAT gateway configuration
##################################################
resource "google_compute_router_nat" "nat" {
  name                               = "${var.application_name}-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}