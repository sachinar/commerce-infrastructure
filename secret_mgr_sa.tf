resource "kubernetes_namespace" "gke_namespace_api_creds" {
  
  depends_on = [module.gke]
  provider   = kubernetes.gke

  metadata {
    annotations = {
      name = "api-creds"
    }

    labels = {
      project         = var.project_name
    }

    name = "api-creds"
    }
}

resource "google_service_account" "secret_mgr_service_account" {
  account_id   = "api-credentials"
  display_name = "Service account for core credentials service"
  depends_on   = [google_project_service.project_services, kubernetes_namespace.gke_namespace_api_creds]
}

resource "google_project_iam_member" "secret_mgr_service_account_iam" {
  project = var.project_id
  count   = length(var.secret_mgr_service_account_roles)
  role    = element(var.secret_mgr_service_account_roles, count.index)
  member  = "serviceAccount:${google_service_account.secret_mgr_service_account.email}"
}

# Add annotation to the Kubernetes service account, using the email address of the Google service account
resource "kubernetes_service_account" "secret_mgr_service_account" {
  depends_on = [module.gke]
  provider   = kubernetes.gke

  metadata {
    name      = google_service_account.secret_mgr_service_account.account_id
    namespace = var.secret_mgr_namespace

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.secret_mgr_service_account.email
    }
  }
}

# Allow the Kubernetes service account to impersonate the Google service account by creating an IAM policy binding between the two
resource "google_service_account_iam_member" "secret_mgr_service_account" {
  service_account_id = google_service_account.secret_mgr_service_account.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.secret_mgr_namespace}/${google_service_account.secret_mgr_service_account.account_id}]"
}