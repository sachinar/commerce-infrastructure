project_id     = "ibo-prod"
project_name   = "ibo-prod"
project_number = "435415796196"
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

target_tags = ["gke-ebo-prod-gke-cluster-89b20f1f-node"]
######### NAT CONFIGURATION ###################
cloud_nat_ports_per_vm          = "4032"
tcp_transitory_idle_timeout_sec = "60"
log_config_enable               = true
log_config_filter               = "ERRORS_ONLY"

######### DB Postgres ####################
postgres_ipv4_address = "10.4.0.0"
postgres_ipv4_prefix  = "20"

public_ip            = 1
authorized_networks  = [
  {
    name  = "sprinkle"
    value = "34.93.254.126/32"
  },
  {
    name  = "kubernetes_ip"
    value = "34.93.106.136/32"
  }
]
database_version     = "POSTGRES_13"
db_master_region     = "asia-south1"
db_master_zone       = "asia-south1-a"
db_availability_type = "REGIONAL"
#db_maintenance_window_day        = 7
#db_maintenance_window_hour       = 22
db_tier                     = "db-custom-4-15360"
db_disk_size                = "20"
inventory_database          = "inventory"
database_instance_name      = "ibo-prd-db"
inventory_namespace         = "inventory"
inventory_secret_name       = "inventory-db-secrets"
postfix_length              = 5
db_backup_enabled           = "true"
db_backup_start_time        = "22:00"
disk_autoresize             = true
redis_tier                  = "STANDARD_HA"
redis_version               = "REDIS_6_X"
ibo_redis_memory_size_db    = 2
ibo_redis_reserved_ip_range = "10.100.0.0/24"

database_flags  = [
  {
    name  = "autovacuum_analyze_scale_factor"
    value = "0"
  },
  {
    name  = "autovacuum_analyze_threshold"
    value = "5000"
  },
  {
    name  = "autovacuum_naptime"
    value = "15"
  },
  {
    name  = "autovacuum_max_workers"
    value = "6"
  },
  {
    name  = "autovacuum_vacuum_cost_delay"
    value = "10"
  },
  {
    name  = "autovacuum_vacuum_cost_limit"
    value = "1000"
  },
  {
    name  = "autovacuum_vacuum_threshold"
    value = "5000"
  },
  {
    name  = "autovacuum_vacuum_scale_factor"
    value = "0"
  },
  {
    name  = "log_autovacuum_min_duration"
    value = "0"
  },
  {
    name  = "autovacuum"
    value = "on"
  }
]
########## DB  namespace ##############
ord_orchestation_database = "order-orchestration"
ord_secret_name           = "oo-db-secrets"
ord_namespace             = "order-orchestration"
payment_namespace         = "payment"
########## GKE VARIABLES ###########
gke_version            = "1.20"
gke_preemptible        = true
master_ipv4_cidr_block = "10.3.0.0/28"

daily_maintenance_window_start = "20:00"
oauth_scopes = [
  "https://www.googleapis.com/auth/trace.append",
  "https://www.googleapis.com/auth/monitoring",
  "https://www.googleapis.com/auth/logging.write",
]

environment = "prod"

gke_encryption_state = "ENCRYPTED"
gke_encryption_key   = ""

workload_identity     = true
enable_shielded_nodes = true

# Application Deployment Service Account
deployment_service_account_roles = ["roles/container.developer", "roles/storage.admin"]

######### LIMIT RANGE ###################
memory_default_limit = "1Gi"
cpu_default_request  = "150m"
memory_default_request = "500Mi"
######## CLUSTER VARIABLES ########
gke_cluster_name        = "ebo-prod-gke-cluster"
gke_instance_type       = "n1-standard-4"
gke_auto_min_count      = 1
gke_auto_max_count      = 5
gke_initial_node_count  = 1
gke_node_pool_disk_size = 100
gke_max_pods_per_node   = 64
gke_namespaces = ["inventory", "ebo", "handler", "order-orchestration", "payment", "tax", "invoice",
"node-master", "order-service", "logistics-service", "core-service", "promise-service", "notification", "fulfillment"]
istio_namespaces = ["istio-operator", "istio-system"]
############# JUMPBOX VARIABLES #######################
jumpbox_deployment_name = "jumpbox"
jumpbox_namespace       = "default"
# jumpbox_docker_registry_url = "registry.gitlab.com"
# jumpbox_docker_registry_user     = "to-be-provided-by-our-pipeline"
# jumpbox_docker_registry_password = "to-be-provided-by-our-pipeline"
jumpbox_number_of_replicas  = 1
jumpbox_docker_image        = "us.gcr.io/ebo-dev-321910/jumpbox@sha256"
jumpbox_docker_image_tag    = "8a79d9f2acdf9451591ecc27c7dc5b4531751f437a5905f3edaf302b5f6337da"
jumpbox_docker_image_policy = "Always"
jumpbox_pull_secret_key     = "gcr-json-key"
############### PUB/SUB VARIABLES ######################

topic_name            = "inventory-threshold-create"
push_pubsub_domain    = "https://services.ibo.com"

############## Cloudflare variables #################
cloudflare_record_name = "pos.ibo.com"
