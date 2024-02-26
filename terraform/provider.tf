// define project ID and region as variables
provider "google" {
    project = "heroic-psyche-414901"
    region  = "europe-west1"
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

