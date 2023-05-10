//Creating LoadBalancer Service
resource "kubernetes_service" "cmdb_wpservice" {
  metadata {
    name = "wp-svc"
    labels = {
      env = "Demo"
    }
  }

  spec {
    type = "LoadBalancer"
    selector = {
      pod = "${kubernetes_deployment.cmdbwp_dep.spec.0.selector.0.match_labels.pod}"
    }

    port {
      name        = "wp-port"
      port        = 80
      target_port = 80
    }
  }

  depends_on = [
    kubernetes_deployment.cmdbwp_dep,
  ]
}
