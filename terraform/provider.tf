terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
        project     = var.project_id
        region      = var.region
      version = "~> 3.52.0"
    }
  }
  required_version = ">= 0.13"
}