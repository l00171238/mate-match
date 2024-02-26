# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = "heroic-psyche-414901"
  region  = "europe-west1"
}

# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "first-my-terraform-state-bucket"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
