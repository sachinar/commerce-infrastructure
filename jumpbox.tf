module "jumpbox" {
  providers = {
    kubernetes = kubernetes.gke
  }

  source                  = "git::https://github.com/ebomart/terraform-modules.git//jumpbox?ref=security_context"
  jumpbox_deployment_name = var.jumpbox_deployment_name
  jumpbox_namespace       = var.jumpbox_namespace
  jumpbox_docker_registry_url      = "us.gcr.io"
  jumpbox_docker_registry_user     = "_json_key"
  jumpbox_docker_registry_password = var.jumpbox_docker_registry_password
  jumpbox_number_of_replicas  = var.jumpbox_number_of_replicas
  jumpbox_docker_image        = var.jumpbox_docker_image
  jumpbox_docker_image_tag    = var.jumpbox_docker_image_tag
  jumpbox_docker_image_policy = var.jumpbox_docker_image_policy
  jumpbox_pull_secret_key     = var.jumpbox_pull_secret_key
}
