# Create a record# Add a record to the domain
resource "cloudflare_record" "platform" {
  zone_id = var.cloudflare_zone_id
  name    = var.cloudflare_record_name
  value   = google_compute_address.istio_ingress_ip.address
  type    = "A"
  ttl     = 1
  proxied = true
}
