# resource "random_string" "inventory_password" {
#   length           = 16
#   special          = true
#   override_special = "@#%&*()-_=+[]{}<>:?"
# }

# resource "random_id" "inventory_postgres_name_postfix" {
#   byte_length = var.postfix_length
# }

# resource "random_string" "inventory_app_user_name" {
#   length  = 8
#   upper   = false
#   special = false
# }

# resource "random_string" "inventory_app_user_password" {
#   length           = 16
#   special          = true
#   override_special = "@#%&*()-_=+[]{}<>:?"
# }

# resource "random_string" "dev_team_db_password" {
#   length           = 16
#   special          = true
#   override_special = "@#%&*()-_=+[]{}<>:?"
# }

# module "inventory_google_postgres" {

#   source               = "git::https://github.com/terraform-google-modules/terraform-google-sql-db//modules/postgresql"
#   name                 = "${var.database_instance_name}-${random_id.inventory_postgres_name_postfix.hex}"
#   random_instance_name = true
#   project_id           = var.project_id
#   database_version     = var.database_version
#   region               = var.db_master_region

#   // Master configurations
#   tier                            = var.db_tier
#   zone                            = var.db_master_zone
#   availability_type               = var.db_availability_type
#   maintenance_window_day          = var.maintenance_window_day
#   maintenance_window_hour         = var.maintenance_window_hour
#   maintenance_window_update_track = "stable"
#   deletion_protection             = false
#   database_flags                  = var.database_flags
#   disk_size                       = var.db_disk_size
#   disk_type                       = var.disk_type
#   disk_autoresize                 = var.disk_autoresize

#   user_labels = {
#     env     = var.environment
#     project = var.project_name
#   }

#   ip_configuration = {
#     ipv4_enabled        = false
#     require_ssl         = false
#     private_network     = google_compute_network.network.self_link
#     authorized_networks = []
#   }

#   backup_configuration = {
#     enabled                        = var.db_backup_enabled
#     start_time                     = var.db_backup_start_time
#     location                       = null
#     point_in_time_recovery_enabled = false
#     transaction_log_retention_days = null
#     retained_backups               = 30
#     retention_unit                 = "COUNT"
#   }

#   insights_config = var.insights_config

#   #  // Read replica configurations
#   read_replicas = var.inventory_read_replicas

#   db_name      = var.inventory_database
#   db_charset   = "UTF8"
#   db_collation = "en_US.UTF8"

#   additional_databases = []

#   user_name     = "inventory-${random_string.inventory_app_user_name.result}"
#   user_password = random_string.inventory_app_user_password.result

#   additional_users = [
#     {
#       name     = "dev-read-user"
#       password = random_string.dev_team_db_password.result
#     },
#   ]

#   depends_on = [google_service_networking_connection.postgres_private_vpc_connection]
# }

# resource "kubernetes_secret" "inventory_app_secret" {
#   provider = kubernetes.gke
#   metadata {
#     name      = var.inventory.secret_name
#     namespace = var.inventory.namespace
#   }

#   data = {
#     DB_HOST     = google_dns_record_set.inventory.postgres_a_record.name
#     DB_NAME     = var.inventory.database
#     DB_PORT     = "5432"
#     DB_USER     = "inventory-${random_string_inventory.app_user_name.result}"
#     DB_PASSWORD = random_string.inventory_app_user_password.result
#   }

#   depends_on = [module.gke]
# }

# resource "google_dns_record_set" "inventory_postgres_a_record" {
#   # Creating 'A' record for the dns zone
#   name         = "inventory.postgres.${google_dns_managed_zone.private-dns-managed-zone.dns_name}"
#   project      = var.project_id
#   managed_zone = google_dns_managed_zone.private-dns-managed-zone.name
#   type         = "A"
#   ttl          = 300
#   rrdatas      = [module.inventory_google_postgres.private_ip_address]
# }

