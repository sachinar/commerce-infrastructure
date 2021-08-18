project_id         = "ebo-staging"
project_name       = "ebo-staging"
project_number     = "770633633132"
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
cloud_nat_ports_per_vm          = "0"
tcp_transitory_idle_timeout_sec = "30"

######### DB Postgres ####################
postgres_ipv4_address = "10.4.0.0"
postgres_ipv4_prefix  = "20"