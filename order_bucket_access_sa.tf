resource "google_service_account" "order_bucket_access_sa" {
  account_id   = "order-file-upload"
  display_name = "Service account for uploading order files"
}

resource "google_storage_bucket_iam_member" "order_service_account_iam" {
  role       = "roles/storage.admin"
  bucket     = "challan-files-${var.environment}"
  member     = "serviceAccount:${google_service_account.order_bucket_access_sa.email}"
  depends_on = [google_storage_bucket.order_file_bucket]
}

resource "google_project_iam_member" "order_service_account_iam" {
  project = var.project_id
  count   = length(var.order_service_account_roles)
  role    = element(var.order_service_account_roles, count.index)
  member  = "serviceAccount:${google_service_account.order_bucket_access_sa.email}"
}

# Add annotation to the Kubernetes service account, using the email address of the Google service account
resource "kubernetes_service_account" "order_service_account" {
  depends_on = [module.gke]
  provider   = kubernetes.gke

  metadata {
    name      = google_service_account.order_bucket_access_sa.account_id
    namespace = var.orderservice_namespace

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.order_bucket_access_sa.email
    }
  }
}

# Allow the Kubernetes service account to impersonate the Google service account by creating an IAM policy binding between the two
resource "google_service_account_iam_member" "order_service_account" {
  service_account_id = google_service_account.order_bucket_access_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.orderservice_namespace}/${google_service_account.order_bucket_access_sa.account_id}]"
}
