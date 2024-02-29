terraform {
    backend "gcs" {
        bucket  = "terraform-state"
        prefix  = "terraform/state"
    }
}

provider "google" {
    credentials = file("service-account.json")
    project     = "prod1-415815"
    region      = "europe-west1"
}

resource "google_storage_bucket" "bucket" {
    name     = "terraform-state"
    location = "europe-west1"
}