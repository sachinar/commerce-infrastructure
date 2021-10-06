module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic              = var.topic_name
  project_id         = var.project_id
  push_subscriptions = []
}
