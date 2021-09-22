module "inventory_redis" {
  source                   = "git::https://github.com/ebomart/terraform-modules.git//redis"
  redis_name               = "inventory-redis"
  redis_memory_size_db     = var.inventory_redis_memory_size_db
  redis_region             = var.region
  redis_tier               = var.redis_tier
  redis_version            = var.redis_version
  redis_authorized_network = google_compute_network.network.self_link
  redis_reserved_ip_range  = var.inventory_redis_reserved_ip_range
  redis_configs            = var.inventory_redis_configs
}

resource "google_dns_record_set" "inventory_redis_a_record" {
  name         = "inventory.redis.${google_dns_managed_zone.private-dns-managed-zone.dns_name}"
  managed_zone = google_dns_managed_zone.private-dns-managed-zone.name
  type         = "A"
  ttl          = 300
  rrdatas      = [module.inventory_redis.ip]
}
