module "inventory_events" {
  source  = "terraform-google-modules/pubsub/google"
  version = "~> 1.8"

  topic              = "inventory-management"
  project_id         = var.project_id
  pull_subscriptions = [
    {
      name             = "inventory-management-view"
    }
  ]
}

