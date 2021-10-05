project_id     = "ebo-staging"
project_name   = "ebo-staging"
project_number = "770633633132"
region         = "asia-south1"

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
subnet_ip_cidr_range          = "10.0.0.0/16"
services_secondary_range_name = "service-ip-range"
services_ipv4_cidr_block      = "10.1.0.0/20"
cluster_secondary_range_name  = "cluster-pod-ip-range"
cluster_ipv4_cidr_block       = "10.2.0.0/16"

target_tags = ["gke-ebo-staging-gke-cluster-8b587279-node"]
######### NAT CONFIGURATION ###################
cloud_nat_ports_per_vm          = "0"
tcp_transitory_idle_timeout_sec = "30"

######### DB Postgres ####################
postgres_ipv4_address = "10.4.0.0"
postgres_ipv4_prefix  = "20"

database_version     = "POSTGRES_13"
db_master_region     = "asia-south1"
db_master_zone       = "asia-south1-a"
db_availability_type = "ZONAL"
#db_maintenance_window_day   = 7
#db_maintenance_window_hour  = 22
db_tier                           = "db-custom-1-3840"
db_disk_size                      = "20"
inventory_database                = "inventory"
database_instance_name            = "ibo-stg-db"
inventory_namespace               = "inventory"
inventory_secret_name             = "inventory-db-secrets"
postfix_length                    = 5
db_backup_enabled                 = "false"
db_backup_start_time              = "22:00"
disk_autoresize                   = false
redis_version                     = "REDIS_5_0"
inventory_redis_memory_size_db    = 1
inventory_redis_reserved_ip_range = "10.100.0.0/24"
########## Order orchestrator DB ##############
ord_orchestation_database = "order-orchestration"
ord_secret_name           = "oo-db-secrets"
ord_namespace             = "order-orchestration"
payment_namespace         = "payment"
########## GKE VARIABLES ###########
gke_version            = "1.20"
gke_preemptible        = true
master_ipv4_cidr_block = "10.3.0.0/28"

daily_maintenance_window_start = "03:00"
oauth_scopes = [
  "https://www.googleapis.com/auth/trace.append",
  "https://www.googleapis.com/auth/monitoring",
  "https://www.googleapis.com/auth/logging.write",
]

environment = "staging"

gke_encryption_state = "ENCRYPTED"
gke_encryption_key   = ""

workload_identity     = true
enable_shielded_nodes = true

# Application Deployment Service Account
deployment_service_account_roles = ["roles/container.developer", "roles/storage.admin"]

######### LIMIT RANGE ###################
memory_default_limit = "1Gi"
cpu_default_request  = "500m"

######## CLUSTER VARIABLES ########
gke_cluster_name        = "ebo-staging-gke-cluster"
gke_instance_type       = "n1-standard-2"
gke_auto_min_count      = 1
gke_auto_max_count      = 5
gke_initial_node_count  = 1
gke_node_pool_disk_size = 100
gke_max_pods_per_node   = 64
gke_namespaces          = ["inventory", "ebo","order-orchestration","handler","payment","tax"]
istio_namespaces        = ["istio-operator", "istio-system"]
############# JUMPBOX VARIABLES #######################
jumpbox_deployment_name = "jumpbox"
jumpbox_namespace       = "default"
# jumpbox_docker_registry_url = "registry.gitlab.com"
# jumpbox_docker_registry_user     = "to-be-provided-by-our-pipeline"
# jumpbox_docker_registry_password = "to-be-provided-by-our-pipeline"
jumpbox_number_of_replicas  = 1
jumpbox_docker_image        = "us.gcr.io/ebo-dev-321910/jumpbox@sha256"
jumpbox_docker_image_tag    = "2029b0e087aea9f062adecde6f780b63778a1d52561d16cbb0e358d2a3368dc2"
jumpbox_docker_image_policy = "Always"

############### PUB/SUB VARIABLES ######################

topic_name                  = []