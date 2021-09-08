resource "google_service_account" "pull_service_account" {
  account_id   = "gcr-pull"
  display_name = "Service account for application deployment"
  depends_on   = [google_project_service.project_services]
}

resource "google_project_iam_member" "pull_service_account_iam" {
  project  = var.project_id
  role     = "roles/viewer"
  member   = "serviceAccount:${google_service_account.pull_service_account.email}"
}

resource "google_service_account_key" "pull_service_account_key" {
  service_account_id = google_service_account.pull_service_account.name
}

resource "google_storage_bucket_object" "pull_service_account_key_bucket_object" {
  name    = "pull-gcr-${var.environment}.key"
  content = google_service_account_key.pull_service_account_key.private_key
  bucket  = var.project_name
}