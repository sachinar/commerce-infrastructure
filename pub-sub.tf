module "pubsub" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"
  
  count               = length(var.topic_name)
  topic               = var.topic_name[count.index]
  project_id          = var.project_id
  push_subscriptions  = []
}