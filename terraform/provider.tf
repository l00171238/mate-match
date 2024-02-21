provider "google" {
    project = var.my_project_id
    region  = var.my_region
  }


terraform {
    backend "gcs" {
      bucket  = "first-terraform-state-bucket"
      prefix  = "terraform/state"
    }




  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.17.0"
    }
  }
}

