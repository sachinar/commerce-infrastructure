project_id         = "ebo-prod"
project_name       = "ebo-prod"
project_number     = "227380419959"
region             = "asia-south1"

google_service_apis = [
  "clouddebugger.googleapis.com",
  "cloudtrace.googleapis.com",
  "cloudbuild.googleapis.com",
  "compute.googleapis.com",
  "container.googleapis.com",
  "dataflow.googleapis.com",
  "dns.googleapis.com",
  "iam.googleapis.com",
  "logging.googleapis.com",
  "monitoring.googleapis.com",
  "pubsub.googleapis.com",
  "servicecontrol.googleapis.com",
  "servicemanagement.googleapis.com",
  "servicenetworking.googleapis.com",
  "sqladmin.googleapis.com",
  "cloudkms.googleapis.com",
  "redis.googleapis.com",
  "cloudfunctions.googleapis.com",
  "oslogin.googleapis.com",
  "secretmanager.googleapis.com",
  "cloudtasks.googleapis.com",
  "iap.googleapis.com",
]

######## GCP NETWORK VARIABLES ############
subnet_ip_cidr_range               = "10.0.0.0/16" 
services_secondary_range_name      = "service-ip-range"
services_ipv4_cidr_block           = "10.1.0.0/20"
cluster_secondary_range_name       = "cluster-pod-ip-range"
cluster_ipv4_cidr_block            = "10.2.0.0/16"

######### NAT CONFIGURATION ###################
cloud_nat_ports_per_vm          = "1024"
tcp_transitory_idle_timeout_sec = "60"
log_config_enable               = true
log_config_filter               = "ERRORS_ONLY"

######### DB Postgres ####################
postgres_ipv4_address = "10.4.0.0"
postgres_ipv4_prefix  = "20"

########## GKE VARIABLES ###########
gke_version                       = "1.20"
gke_preemptible                   = true
master_ipv4_cidr_block            = "10.3.0.0/28" 

daily_maintenance_window_start = "03:00"
oauth_scopes = [
  "https://www.googleapis.com/auth/trace.append",
  "https://www.googleapis.com/auth/monitoring",
  "https://www.googleapis.com/auth/logging.write",
]

environment           = "production"

gke_encryption_state  = "ENCRYPTED"
gke_encryption_key    = ""

workload_identity     = true
enable_shielded_nodes = true
######## CLUSTER VARIABLES ########
gke_cluster_name          = "ebo-prod-gke-cluster"
gke_instance_type         = "n1-standard-2"
gke_auto_min_count        = 1
gke_auto_max_count        = 5
gke_initial_node_count    = 1
gke_node_pool_disk_size   = 100
gke_max_pods_per_node     = 64