terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
        credentials = base64decode(var.service_account_key)
        project     = var.project_id
        region      = var.region
      version = "~> 3.52.0"
    }
  }
  required_version = ">= 0.13"
}