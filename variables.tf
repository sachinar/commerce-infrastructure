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

variable "cloud_nat_log_config" {
  description = "The minimum number of ports per VM for cloud nat"
  type = object({
    enable = bool
    filter = string
  })
}