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