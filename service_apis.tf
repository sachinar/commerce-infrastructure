resource "google_project_service" "project_services" {
  for_each                   = var.google_service_apis
  project                    = var.project_id
  service                    = each.key
  disable_dependent_services = true
  disable_on_destroy         = true

  provisioner "local-exec" {
    command = "sleep 180"
  }

}
