resource "google_service_account" "oidc_pubsub_account" {
  account_id   = "push-pubsub-user"
  display_name = "Service account for pubsub push subscription"
}
