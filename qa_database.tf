locals {

  databases = { for db in var.additional_databases : db.dbname => db }
  
  }

resource "random_string" "random_password_create" {
  count            = var.environment == "dev" ? 1:0
  length           = 16
  special          = true
  override_special = "@#%&*()-_=+[]{}<>:?"  
}


resource "google_sql_database" "additional_databases" {

  for_each   = local.databases
  project    = var.project_id
  name       = each.value.dbname
  charset    = "UTF8"
  collation  = "en_US.UTF8"
  instance   = module.inventory_google_postgres.instance_name
}

resource "google_sql_user" "additional_databases" {

  for_each   = local.databases
  project    = var.project_id
  name       = each.value.dbuser
  password   = random_string.random_password_create[count.index].result
  instance   = module.inventory_google_postgres.instance_name
}


# secret creater 

resource "kubernetes_secret" "additional_databases" {

  for_each   = local.databases
  provider = kubernetes.gke
  metadata {
    name      = each.value.sname
    namespace = each.value.namespace
  }

  data = {
    DB_HOST     = google_dns_record_set.inventory_postgres_a_record.name
    DB_NAME     = each.value.dbname
    DB_PORT     = "5432"
    DB_USER     = each.value.dbuser
    DB_PASSWORD = random_string.random_password_create[count.index].result
  }

  depends_on = [module.gke]
}
