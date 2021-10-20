module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic              = var.topic_name
  project_id         = var.project_id
  push_subscriptions = [
    {
      name                       = "inventory-threshold-push"                                                                               
      push_endpoint              = "${var.push_pubsub_domain}/common/v1/resource"                                         
      # oidc_service_account_email = "sa@example.com"                                          
      dead_letter_topic          = "projects/my-pubsub-project/topics/invetory-threshold-push-dl-topic"
      max_delivery_attempts      = 5                                               
      maximum_backoff            = "600s"                                               
      minimum_backoff            = "300s"                                             
    }
  ]
}
