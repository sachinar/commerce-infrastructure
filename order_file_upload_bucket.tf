resource "google_storage_bucket" "order_file_bucket" {
  #ts:skip=accurics.gcp.IAM.122 Already applied
  name     = "challan-files-${var.environment}"
  location = "ASIA"

  uniform_bucket_level_access = true
}