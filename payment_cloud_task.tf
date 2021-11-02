resource "google_cloud_tasks_queue" "payment_charge_status_queue" {
  provider = google-beta
  name     = "payment-charge-status-queue"
  location = var.cloud_tasks_region
  project  = var.project_id

  retry_config {
    max_attempts = 5
    max_retry_duration = "864000s"
    max_backoff = "600s"
    min_backoff = "3600s"
    max_doublings = 4
  }
}

