resource "google_service_account" "invoice_bucket_access_sa" {
  account_id   = "invoice-file-upload"
  display_name = "Service account for uploading invoice files"
}

resource "google_storage_bucket_iam_member" "invoice_service_account_iam" {
  role   = "roles/storage.admin"
  bucket = "invoice-file-upload-${var.environment}"
  member = "serviceAccount:${google_service_account.invoice_bucket_access_sa.email}"
  depends_on = [google_storage_bucket.invoice_file_bucket]
}

# Add annotation to the Kubernetes service account, using the email address of the Google service account
resource "kubernetes_service_account" "invoice_service_account" {
  depends_on = [module.gke]
  provider   = kubernetes.gke

  metadata {
    name      = google_service_account.invoice_bucket_access_sa.account_id
    namespace = var.invoice_namespace

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.invoice_bucket_access_sa.email
    }
  }
}

# Allow the Kubernetes service account to impersonate the Google service account by creating an IAM policy binding between the two
resource "google_service_account_iam_member" "invoice_service_account" {
  service_account_id = google_service_account.invoice_bucket_access_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.invoice_namespace}/${google_service_account.invoice_bucket_access_sa.account_id}]"
}