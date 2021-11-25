resource "google_service_account" "bq_grafana" {
  account_id   = "bigquery-grafana"
  display_name = "Service account for Big query and Grafana"
  depends_on   = [google_project_service.project_services]
}

resource "google_project_iam_member" "bq_grafana_iam" {
  for_each = var.bq_grafana_roles
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.bq_grafana.email}"
}

resource "google_service_account_key" "bq_grafana_key" {
  service_account_id = google_service_account.bq_grafana.name
}

# resource "google_kms_secret_ciphertext" "bq_grafana_bucket_object" {
#   crypto_key = google_kms_crypto_key.crypto_key.id
#   plaintext  = base64decode(google_service_account_key.bq_grafana_key.private_key)
# }

resource "google_storage_bucket_object" "bq_grafana_key_bucket_object" {
  name    = "bigquery-grafana-${var.environment}.key"
  content = google_service_account_key.bq_grafana_key.private_key
  bucket  = var.project_name
}