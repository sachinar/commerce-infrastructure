terraform {
  required_version = ">= 1.0.5, <=1.0.8"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.79.0, <=4.0.0"
    }

    google-beta = {
      version = ">= 3.85.0, <=4.0.0"
      source  = "hashicorp/google-beta"
    }

    kubernetes = {
      version = "~>2.4.0"
      source  = "hashicorp/kubernetes"
    }

    helm = {
      version = "~>2.3.0"
      source  = "hashicorp/helm"
    }

    cloudflare = {
      version = ">= 3.2.0, <=3.3.0"
      source  = "cloudflare/cloudflare"
    }
  }

}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}