resource "kubernetes_namespace" "gke_namespace" {

  depends_on = [module.gke]
  provider   = kubernetes.gke
  for_each   = var.istio_namespaces

  metadata {
    annotations = {
      name = each.key
    }
    name = each.key
  }
}