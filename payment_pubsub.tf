module "payment_events" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic              = "payment-events"
  project_id         = var.project_id
  pull_subscriptions = [
    {
      name             = "payments-internal-payment-events-subscription"
    }
  ]
}

module "payment_ticket_events_push" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic              = "payment-refund-ticket-events"
  project_id         = var.project_id

  pull_subscriptions = [
    {
      name             = "payments-internal-payment-events-subscription"
    }
  ]
  
  push_subscriptions = [
    {
      name                       = "payments-internal-payment-refund-ticket-events-subscription"                                                                               
      push_endpoint              = "${var.push_pubsub_domain}/payment/v1/payment-refund/ticket-event"                                         
      # oidc_service_account_email = "sa@example.com"                                            
    }
  ]
}
