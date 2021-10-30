resource "google_dns_managed_zone" "private-dns-managed-zone" {
  provider    = google-beta
  name        = "${var.project_name}-private-dns-managed-zone"
  dns_name    = "commerce.internal." # trailing dot is necessary
  description = "Private DNS zone for ${var.project_name}"
  visibility  = "private"

  private_visibility_config {
    networks {
      network_url = google_compute_network.network.self_link
    }
  }
}
