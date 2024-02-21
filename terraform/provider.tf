terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.52.0"
      credentials = var.service_account_key
    }
  }
  required_version = ">= 0.13"
}