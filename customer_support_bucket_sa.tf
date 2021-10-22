resource "google_storage_bucket" "customer_file_bucket" {
  #ts:skip=accurics.gcp.IAM.122 Already applied
  name     = "customer-support-files-${var.environment}"
  location = "ASIA"

  uniform_bucket_level_access = true
}

resource "google_service_account" "customer_bucket_access_sa" {
  account_id   = "customer-support-files"
  display_name = "Service account for uploading customer files"
}

resource "google_storage_bucket_iam_member" "customer_service_account_iam" {
  role       = "roles/storage.admin"
  bucket     = "customer-support-files-${var.environment}"
  member     = "serviceAccount:${google_service_account.customer_bucket_access_sa.email}"
  depends_on = [google_storage_bucket.customer_file_bucket]
}

resource "google_project_iam_member" "customer_service_account_iam" {
  project = var.project_id
  count   = length(var.customer_service_account_roles)
  role    = element(var.customer_service_account_roles, count.index)
  member  = "serviceAccount:${google_service_account.customer_bucket_access_sa.email}"
}

# Add annotation to the Kubernetes service account, using the email address of the Google service account
resource "kubernetes_service_account" "customer_service_account" {
  depends_on = [module.gke]
  provider   = kubernetes.gke

  metadata {
    name      = google_service_account.customer_bucket_access_sa.account_id
    namespace = var.ebo_namespace

    annotations = {
      "iam.gke.io/gcp-service-account" = google_service_account.customer_bucket_access_sa.email
    }
  }
}

# Allow the Kubernetes service account to impersonate the Google service account by creating an IAM policy binding between the two
resource "google_service_account_iam_member" "customer_service_account" {
  service_account_id = google_service_account.customer_bucket_access_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[${var.ebo_namespace}/${google_service_account.customer_bucket_access_sa.account_id}]"
}