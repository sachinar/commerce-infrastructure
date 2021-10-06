resource "google_storage_bucket" "invoice_file_bucket" {
  #ts:skip=accurics.gcp.IAM.122 Already applied
  name     = "invoice-file-upload-${var.environment}"
  location = "ASIA"

  uniform_bucket_level_access = true
}
