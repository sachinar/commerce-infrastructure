module "ibo_redis" {
  count                    = var.environment == "dev" ? 1 : 0  
  source                   = "git::https://github.com/ebomart/terraform-modules.git//redis"
  redis_name               = "ibo-redis"
  redis_memory_size_db     = var.ibo_redis_memory_size_db
  redis_region             = var.region
  redis_tier               = var.redis_tier
  redis_version            = var.redis_version
  redis_authorized_network = google_compute_network.network.self_link
  redis_reserved_ip_range  = var.ibo_redis_reserved_ip_range
  redis_configs            = var.ibo_redis_configs
  auth_enabled             = true
}

resource "google_dns_record_set" "ibo_redis_a_record" {
  count        = var.environment == "dev" ? 1 : 0    
  name         = "ibo.redis.${google_dns_managed_zone.private-dns-managed-zone.dns_name}"
  managed_zone = google_dns_managed_zone.private-dns-managed-zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [module.ibo_redis[0].ip]
}
