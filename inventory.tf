resource "google_service_account" "inventory_service_account" {
  account_id   = "inventory-service"
  display_name = "Service account for inventory` application"
  depends_on   = [google_project_service.project_services]
}

resource "google_project_iam_member" "inventory_service_account_iam" {
  project = var.project_id
  count   = length(var.inventory_service_account_roles)
  role    = element(var.inventory_service_account_roles, count.index)
  member  = "serviceAccount:${google_service_account.inventory_service_account.email}"
}

# Add annotation to the Kubernetes service account, using the email address of the Google service account
resource "kubernetes_service_account" "inventory_service_account" {
  depends_on = [module.gke]
  provider   = kubernetes.gke

  metadata {
    name      = google_service_account.inventory_service_account.account_id
    namespace = var.inventory_namespace

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.inventory_service_account.email
    }
  }
}

# Allow the Kubernetes service account to impersonate the Google service account by creating an IAM policy binding between the two
resource "google_service_account_iam_member" "inventory_service_account" {
  service_account_id = google_service_account.inventory_service_account.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.inventory_namespace}/${google_service_account.inventory_service_account.account_id}]"
}
