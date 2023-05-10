//Outputs
output "network" {
  value = var.vpc

  depends_on = [
    google_compute_network.basevpc
  ]
}
