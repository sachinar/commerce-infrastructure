resource "google_service_account" "invoice_bucket_access_sa" {
  account_id   = "invoice-file-upload"
  display_name = "Service account for uploading invoice files"
}

resource "google_storage_bucket_iam_member" "invoice_service_account_iam" {
  role   = "roles/storage.admin"
  bucket = "invoice-file-upload-${var.environment}"
  member = "serviceAccount:${google_service_account.invoice_bucket_access_sa.email}"
}
