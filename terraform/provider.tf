// define project ID and region as variables
provider "google" {
    project = var.my_project_id
    region  = var.my_region
  }

// create a bucket to store State file

terraform {
    backend "gcs" {
      bucket  = "first-my-terraform-state-bucket"
      prefix  = "terraform/state"
    }


// version control for the provider

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.17.0"
    }
  }
}

