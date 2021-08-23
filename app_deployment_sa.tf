resource "google_service_account" "deployment_service_account" {
  account_id   = "app-deployment"
  display_name = "Service account for application deployment"
  depends_on   = [google_project_service.project_services]
}

resource "google_project_iam_member" "deployment_service_account_iam" {
  for_each = var.deployment_service_account_roles
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.deployment_service_account.email}"
}

resource "google_service_account_key" "deployment_service_account_key" {
  service_account_id = google_service_account.deployment_service_account.name
}

resource "google_kms_secret_ciphertext" "deployment_service_account_key_bucket_object" {
  crypto_key = google_kms_crypto_key.crypto_key.id
  plaintext  = base64decode(google_service_account_key.deployment_service_account_key.private_key)
}

resource "google_storage_bucket_object" "deployment_service_account_key_bucket_object" {
  name    = "app-deployment-${var.environment}.key"
  content = google_kms_secret_ciphertext.deployment_service_account_key_bucket_object.ciphertext
  bucket  = var.project_name
}
