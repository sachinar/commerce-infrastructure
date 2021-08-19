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

variable "gke_dns_cache_enabled" {
  type        = bool
  description = "Enable the Node DNS local caching"
  default     = true
}