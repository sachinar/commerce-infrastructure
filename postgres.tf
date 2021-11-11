resource "random_string" "inventory_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_id" "inventory_postgres_name_postfix" {
  byte_length = var.postfix_length
}

resource "random_string" "inventory_app_user_name" {
  length  = 8
  upper   = false
  special = false
}

resource "random_string" "inventory_app_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_string" "ord_orchestrator_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_string" "payment_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_string" "tax_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_string" "invoice_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}


resource "random_string" "nodemaster_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_string" "orderservice_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_string" "logistics_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_string" "notification_user_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

resource "random_string" "dev_team_db_password" {
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"
}

module "inventory_google_postgres" {

  source               = "git::https://github.com/terraform-google-modules/terraform-google-sql-db//modules/postgresql"
  name                 = var.database_instance_name
  random_instance_name = true
  project_id           = var.project_id
  database_version     = var.database_version
  region               = var.db_master_region

  // Master configurations
  tier                            = var.db_tier
  zone                            = var.db_master_zone
  availability_type               = var.db_availability_type
  maintenance_window_day          = var.maintenance_window_day
  maintenance_window_hour         = var.maintenance_window_hour
  maintenance_window_update_track = "stable"
  deletion_protection             = false
  database_flags                  = var.database_flags
  disk_size                       = var.db_disk_size
  disk_type                       = var.disk_type
  disk_autoresize                 = var.disk_autoresize

  user_labels = {
    env     = var.environment
    project = var.project_name
  }

  ip_configuration = {
    ipv4_enabled        = false
    require_ssl         = false
    private_network     = google_compute_network.network.self_link
    authorized_networks = []
  }

  backup_configuration = {
    enabled                        = var.db_backup_enabled
    start_time                     = var.db_backup_start_time
    location                       = null
    point_in_time_recovery_enabled = false
    transaction_log_retention_days = null
    retained_backups               = 30
    retention_unit                 = "COUNT"
  }

  insights_config = var.insights_config

  #  // Read replica configurations
  read_replicas = var.inventory_read_replicas

  db_name      = var.inventory_database
  db_charset   = "UTF8"
  db_collation = "en_US.UTF8"

  additional_databases = [
    {
      name      = var.ord_orchestation_database
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
    {
      name      = var.payment_database
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
    {
      name      = var.tax_database
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
    {
      name      = var.invoice_database
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
    {
      name      = var.nodemaster_database
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
    {
      name      = var.orderservice_database
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
    {
      name      = var.logistics_database
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },
    {
      name      = var.notification_database
      charset   = "UTF8"
      collation = "en_US.UTF8"
    },    
  ]

  user_name     = "inventory-${random_string.inventory_app_user_name.result}"
  user_password = random_string.inventory_app_user_password.result

  additional_users = [
    {
      name     = "dev-read-user"
      password = random_string.dev_team_db_password.result
    },
    {
      name     = "ord-orchestrator-user"
      password = random_string.ord_orchestrator_user_password.result
    },
    {
      name     = "payment-user"
      password = random_string.payment_user_password.result
    },
    {
      name     = "tax-user"
      password = random_string.tax_user_password.result
    },
    {
      name     = "invoice-user"
      password = random_string.invoice_user_password.result
    },
    {
      name     = "nodemaster-user"
      password = random_string.nodemaster_user_password.result
    },
    {
      name     = "orderservice-user"
      password = random_string.orderservice_user_password.result
    },
    {
      name     = "logistics-user"
      password = random_string.logistics_user_password.result
    },
    {
      name     = "notification-user"
      password = random_string.notification_user_password.result
    },    
  ]

  depends_on = [google_service_networking_connection.postgres_private_vpc_connection]
}

resource "google_dns_record_set" "inventory_postgres_a_record" {
  # Creating 'A' record for the dns zone
  name         = "ibo.postgres.${google_dns_managed_zone.private-dns-managed-zone.dns_name}"
  project      = var.project_id
  managed_zone = google_dns_managed_zone.private-dns-managed-zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [module.inventory_google_postgres.private_ip_address]
}

resource "kubernetes_secret" "inventory_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.inventory_secret_name
    namespace = var.inventory_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.inventory_database
    DB_PORT     = "5432"
    DB_USER     = "inventory-${random_string.inventory_app_user_name.result}"
    DB_PASSWORD = random_string.inventory_app_user_password.result
  }

  depends_on = [module.gke]
}

# Order orchestrator
resource "kubernetes_secret" "ord_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.ord_secret_name
    namespace = var.ord_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.ord_orchestation_database
    DB_PORT     = "5432"
    DB_USER     = "ord-orchestrator-user"
    DB_PASSWORD = random_string.ord_orchestrator_user_password.result
  }

  depends_on = [module.gke]
}

# Payment orchestrator
resource "kubernetes_secret" "payment_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.payment_secret_name
    namespace = var.payment_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.payment_database
    DB_PORT     = "5432"
    DB_USER     = "payment-user"
    DB_PASSWORD = random_string.payment_user_password.result
  }

  depends_on = [module.gke]
}

# tax 
resource "kubernetes_secret" "tax_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.tax_secret_name
    namespace = var.tax_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.tax_database
    DB_PORT     = "5432"
    DB_USER     = "tax-user"
    DB_PASSWORD = random_string.tax_user_password.result
  }

  depends_on = [module.gke]
}

# invoice
resource "kubernetes_secret" "invoice_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.invoice_secret_name
    namespace = var.invoice_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.invoice_database
    DB_PORT     = "5432"
    DB_USER     = "invoice-user"
    DB_PASSWORD = random_string.invoice_user_password.result
  }

  depends_on = [module.gke]
}

# nodemaster 
resource "kubernetes_secret" "nodemaster_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.nodemaster_secret_name
    namespace = var.nodemaster_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.nodemaster_database
    DB_PORT     = "5432"
    DB_USER     = "nodemaster-user"
    DB_PASSWORD = random_string.nodemaster_user_password.result
  }

  depends_on = [module.gke]
}

# order-service
resource "kubernetes_secret" "orderservice_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.orderservice_secret_name
    namespace = var.orderservice_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.orderservice_database
    DB_PORT     = "5432"
    DB_USER     = "orderservice-user"
    DB_PASSWORD = random_string.orderservice_user_password.result
  }

  depends_on = [module.gke]
}


# logistics
resource "kubernetes_secret" "logistics_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.logistics_secret_name
    namespace = var.logistics_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.logistics_database
    DB_PORT     = "5432"
    DB_USER     = "logistics-user"
    DB_PASSWORD = random_string.logistics_user_password.result
  }

  depends_on = [module.gke]
}

# notification
resource "kubernetes_secret" "notification_app_secret" {
  provider = kubernetes.gke
  metadata {
    name      = var.notification_secret_name
    namespace = var.notification_namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = var.notification_database
    DB_PORT     = "5432"
    DB_USER     = "notification-user"
    DB_PASSWORD = random_string.notification_user_password.result
  }

  depends_on = [module.gke]
}