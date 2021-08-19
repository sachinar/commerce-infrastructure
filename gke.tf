locals {
  # Hack to work around https://github.com/hashicorp/terraform/issues/15605 and https://github.com/hashicorp/terraform/issues/16380
  gke_management_encryption_key = var.gke_encryption_state == "DECRYPTED" ? "" : google_kms_crypto_key.crypto_key.self_link
}

provider "kubernetes" {
  alias                  = "gke"
  load_config_file       = false
  host                   = module.gke.gke_cluster_endpoint
  token                  = module.gke.google_client_config_access_token
  cluster_ca_certificate = base64decode(module.gke.gke_cluster_cluster_ca_certificate)
}

module "gke" {
  source                         = "git::https://github.com/ebomart/terraform-modules.git//gke"
  environment                    = var.environment
  project_name                   = var.project_id
  cluster_name                   = var.gke_cluster_name
  region                         = var.region
  network                        = google_compute_network.network.self_link
  subnetwork                     = google_compute_subnetwork.subnetwork.self_link
  gke_version                    = var.gke_version
  gke_instance_type              = var.gke_instance_type
  gke_auto_min_count             = var.gke_auto_min_count
  gke_auto_max_count             = var.gke_auto_max_count
  gke_preemptible                = var.gke_preemptible
  max_pods_per_node              = var.gke_max_pods_per_node
  workload_identity              = var.workload_identity
  enable_shielded_nodes          = var.enable_shielded_nodes

  initial_node_count             = var.gke_initial_node_count
  node_pool_disk_size            = var.gke_node_pool_disk_size
  oauth_scopes                   = var.oauth_scopes
  daily_maintenance_window_start = var.daily_maintenance_window_start

  master_ipv4_cidr_block        = var.master_ipv4_cidr_block
  cluster_secondary_range_name  = var.cluster_secondary_range_name
  services_secondary_range_name = var.services_secondary_range_name

  gke_encryption_state = var.gke_encryption_state
  gke_encryption_key   = local.gke_management_encryption_key

  disable_istio_addons          = true
  # dns_cache_enabled             = var.gke_dns_cache_enabled # Used in module
  default_max_pods_per_node     = var.default_max_pods_per_node

  depends_on = [resource.google_project_iam_member.container_service_account]
}
