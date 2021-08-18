resource "google_compute_network" "network" {
  name                    = "${var.project_name}-network"
  auto_create_subnetworks = false
  depends_on              = [google_project_service.project_services]
}