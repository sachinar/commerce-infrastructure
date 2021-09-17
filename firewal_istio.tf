resource "google_compute_firewall" "istio_rule" {

  name          = "${var.gke_cluster_name}-istio-allow-firewall"
  project       = var.project_id
  network       = google_compute_network.network.self_link
  priority      = 1000
  direction     = "INGRESS"
  source_ranges = [var.master_ipv4_cidr_block]
  target_tags   = var.target_tags

  allow {
    protocol = "tcp"
    ports    = ["15017"]
  }
}