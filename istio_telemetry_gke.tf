# ==========================
# ISTIO TELEMETRY PROXY
# Expose Prometheus Securely
# ==========================
resource "kubernetes_secret" "prometheus_proxy_kubernetes_secret" {
  count    = var.environment == "dev" ? 1:0
  provider = kubernetes.gke

  metadata {
    name      = "prometheus-proxy-auth"
    namespace = "monitoring"
  }

  data = {
    htpasswd = var.prometheus_htpasswd
  }

  depends_on = [
    module.gke
  ]
}

module "istio_telemetry_proxy" {
  count    = var.environment == "dev" ? 1:0

  source       = "git::https://github.com/ebomart/terraform-modules.git//addons/istio-telemetry-proxy"
  release_name = "istio-telemetry-proxy"
  namespace    = "monitoring"
  values = [file("environment/${var.environment}/istio-telemetry-management-values.yaml")]
  istio_flag             = "false"
  prometheus_secret_name = "prometheus-proxy-auth"
}
