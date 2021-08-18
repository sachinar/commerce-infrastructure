resource "google_compute_network" "network" {
  name                    = "${var.project_name}-network"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.project_services]
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "${var.project_name}-subnetwork"
  ip_cidr_range = var.subnet_ip_cidr_range
  region        = var.region
  network       = google_compute_network.network.name

  secondary_ip_range {
    range_name    = var.cluster_secondary_range_name
    ip_cidr_range = var.cluster_ipv4_cidr_block
  }

  secondary_ip_range {
    range_name    = var.services_secondary_range_name
    ip_cidr_range = var.services_ipv4_cidr_block
  }

  private_ip_google_access = true
}

resource "google_compute_router" "router" {
  name    = "${var.project_name}-router"
  region  = var.region
  network = google_compute_network.network.name
}