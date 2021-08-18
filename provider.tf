terraform {
  required_version = ">= 1.0.3"
  required_providers {
    google = {
        source = "hashicorp/google"
        version = ">= 3.79.0, <=4.0.0"
    }
    google-beta = {
      version = ">= 3.79.0, <=4.0.0"
      source  = "hashicorp/google-beta"
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
