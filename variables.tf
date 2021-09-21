variable "google_service_apis" {
  type        = set(string)
  description = "Google service APIs to enable"
}

variable "project_name" {
  type        = string
  description = "GCP project Name"
}

variable "project_number" {
  type        = string
  description = "GCP Project Number"
}

variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
    type       = string
    description = "GCP project region"
}

variable "subnet_ip_cidr_range" {
  type        = string
  description = "Subnet CIDR block"
}

variable "cluster_secondary_range_name" {
  type        = string
  description = "Cluster IP range name for GKE  cluster"
}

variable "cluster_ipv4_cidr_block" {
  type        = string
  description = "Cluster IP ranges for GKE  cluster"
}

variable "services_secondary_range_name" {
  type        = string
  description = "Services IP range name for GKE  cluster"
}

variable "services_ipv4_cidr_block" {
  type        = string
  description = "Services IP ranges for GKE  cluster"
}

variable "target_tags" {
  description = "target tags for Istio port 15017 white listing"
  type        = list(string)
}
######### NAT CONFIGURATION ###################
variable "cloud_nat_ports_per_vm" {
  description = "The minimum number of ports per VM for cloud nat"
  type        = string
}

variable "tcp_transitory_idle_timeout_sec" {
  description = "The value for tcp transitory idle timeout in sec"
  type        = string
}

variable "log_config_enable" {
  type        = bool
  description = "Indicates whether or not to export logs"
  default     = false
}

variable "log_config_filter" {
  type        = string
  description = "Specifies the desired filtering of logs on this NAT. Valid values are: \"ERRORS_ONLY\", \"TRANSLATIONS_ONLY\", \"ALL\""
  default     = "ALL"
}

variable "enable_endpoint_independent_mapping" {
  type        = bool
  description = "Specifies if endpoint independent mapping is enabled."
  default     = null
}

###########DB Variables ##########
variable "postgres_ipv4_address" {
  type        = string
  description = "CIDR block for the postgres database"
}

variable "postgres_ipv4_prefix" {
  type        = string
  description = "prefix block for the postgres database"
}

########### GKE VARIABLES ##############
variable "gke_version" {
  type        = string
  description = "The kubernetes version to use"
}

variable "gke_preemptible" {
  type        = bool
  description = "flag for GKE pre-emptible"
}

variable "daily_maintenance_window_start" {
  type        = string
  description = "Daily maintenance window start time"
}

variable "oauth_scopes" {
  description = "oauth scopes for gke cluster"
  type        = list(string)
}

variable "environment" {
  type        = string
  description = "Enviroment where cluster has to be created"
}

variable "gke_encryption_state" {
  type        = string
  description = "gke cluster encryption state"
}

variable "gke_encryption_key" {
  type        = string
  description = "gke cluster encryption key"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "IPv4 CIDR Block for Master Nodes"
}

variable "workload_identity" {
  type    = bool
  default = false
}

variable "enable_shielded_nodes" {
  type        = bool
  default     = false
  description = "Enable the Shielded nodes features in all the nodes in a cluster"
}

########### GKEVARIABLES ##############
variable "gke_cluster_name" {
  type        = string
  description = "Name of GKE cluster"
}

variable "gke_max_pods_per_node" {
  type        = string
  description = "Number of max pods per node"
}

variable "gke_instance_type" {
  type        = string
  description = "the GKE instance type"
}

variable "gke_initial_node_count" {
  type        = number
  description = "The initial node count for the default node pool"
}

variable "gke_node_pool_disk_size" {
  type        = number
  description = "Disk Size for GKE Nodes"
}

variable "gke_auto_min_count" {
  type        = number
  description = "The minimum number of VMs in the pool"
}

variable "gke_auto_max_count" {
  type        = number
  description = "The maximum number of VMs in the pool"
}

variable "default_max_pods_per_node" {
  description = "The maximum number of pods to schedule per node"
  default     = 64
}

variable "gke_namespaces" {
  type        = set(string)
  description = "Namespaces to be created after cluster creation"
}

variable "istio_namespaces" {
  type        = set(string)
  description = "Namespaces for istio to be created after cluster creation"
}
############ LIMIT VARIABLES ################
variable "memory_default_limit" {
  type        = string
  description = "default memory limit"
}

variable "cpu_default_request" {
  type        = string
  description = "default cpu request"
}

####################### DB Variables ########################
variable "random_instance_name" {
  type        = bool
  description = "Sets random suffix at the end of the Cloud SQL resource name"
  default     = false
}

// required
variable "database_version" {
  description = "The database version to use"
  type        = string
}

variable "database_instance_name" {
  description = "The database version to use"
  type        = string
}

variable "inventory_namespace" {
  description = "The namespace to use"
  type        = string
}

variable "inventory_secret_name" {
  description = "The the secret name to use"
  type        = string
}

variable "inventory_database" {
  description = "The database to use"
  type        = string
}

variable "inventory_read_replicas" {
  type        = list(map(any))
  description = "read replica instance"
  default     = []
}

variable "tier" {
  description = "The tier for the master instance."
  type        = string
  default     = "db-f1-micro"
}

variable "postfix_length" {
  description = "the length of random string to be suffix for database name"
  type        = number
}

variable "db_master_region" {
  type        = string
  description = "The region for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
}

variable "db_tier" {
  type = string
}

variable "db_disk_size" {
  description = "The size of DB data disk, in GB"
  type        = string
}

variable "db_backup_enabled" {
  description = "True if backup configuration is enabled"
  type        = string
}

variable "db_backup_start_time" {
  description = "HH:MM format time indicating when the backup configuration starts"
  type        = string
}

variable "db_availability_type" {
  description = "Specifies whether the DB instance should be set up for high availability (REGIONAL) or single zone (ZONAL)"
  type        = string
}

variable "db_master_zone" {
  type        = string
  description = "The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`."
}

variable "activation_policy" {
  description = "The activation policy for the master instance.Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  type        = string
  default     = "ALWAYS"
}

variable "availability_type" {
  description = "The availability type for the master instance.This is only used to set up high availability for the PostgreSQL instance. Can be either `ZONAL` or `REGIONAL`."
  type        = string
  default     = "ZONAL"
}

variable "disk_autoresize" {
  description = "Configuration to increase storage size."
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "The disk size for the master instance."
  default     = 10
}

variable "disk_type" {
  description = "The disk type for the master instance."
  type        = string
  default     = "PD_SSD"
}

variable "pricing_plan" {
  description = "The pricing plan for the master instance."
  type        = string
  default     = "PER_USE"
}

variable "maintenance_window_day" {
  description = "The day of week (1-7) for the master instance maintenance."
  type        = number
  default     = 1
}

variable "maintenance_window_hour" {
  description = "The hour of day (0-23) maintenance window for the master instance maintenance."
  type        = number
  default     = 23
}

variable "maintenance_window_update_track" {
  description = "The update track of maintenance window for the master instance maintenance.Can be either `canary` or `stable`."
  type        = string
  default     = "canary"
}

variable "database_flags" {
  description = "The database flags for the master instance. See [more details](https://cloud.google.com/sql/docs/postgres/flags)"
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "insights_config" {
  description = "The insights_config settings for the database."
  type = object({
    query_string_length     = number
    record_application_tags = bool
    record_client_address   = bool
  })
  default = null
}

variable "deployment_service_account_roles" {
  description = "Role for deployment of application to GCP"
  type        = set(string)
}

########## JUMPBOX VARIABLES ###############

variable "jumpbox_deployment_name" {
  type        = string
  description = "Jumpbox application name"
}

variable "jumpbox_namespace" {
  type        = string
  description = "Kubernetes namespace to use to deploy Jumpbox"
  default     = "default"
}

variable "jumpbox_number_of_replicas" {
  type        = number
  description = "Number of replicas of our jumpbox"
  default     = 1
}

variable "jumpbox_docker_image" {
  type        = string
  description = "Docker image name of our jumpbox container"
}

variable "jumpbox_docker_image_tag" {
  type        = string
  description = "Docker image tag of our jumpbox container"
}

variable "jumpbox_docker_image_policy" {
  type        = string
  description = "Docker image policy of our jumpbox container (Always, Never, IfNotPresent)"
}

######## TF VAR from CI ######
variable "pull_gcr_auth" {
  type        = string
  description = "GCR pull secrets"
  default     = ""
}