provider "google" {
    credentials = file("service-account.json")
    project     = "prod1-415815"
    region      = "europe-west1"
}

resource "google_compute_network" "vpc" {
    name                    = "vpc"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
    name          = "subnetwork"
    ip_cidr_range = "10.0.0.0/16"
    region        = "europe-west1"
    network       = google_compute_network.vpc.self_link
    secondary_ip_range {
        range_name    = "pods"
        ip_cidr_range = "10.1.0.0/16"
    }
    secondary_ip_range {
        range_name    = "services"
        ip_cidr_range = "10.2.0.0/16"
    }
}

resource "google_container_cluster" "primary" {
    name     = "my-gke-cluster"
    location = "europe-west1"

    remove_default_node_pool = true
    initial_node_count       = 1


    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.subnetwork.self_link
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
    name       = "my-node-pool"
    location   = "europe-west1-b"
    cluster    = google_container_cluster.primary.name
    node_count = 1

    node_config {
        preemptible  = true
        machine_type = "n1-standard-1"

        metadata = {
            disable-legacy-endpoints = "true"
        }

        oauth_scopes = [
            "https://www.googleapis.com/auth/logging.write",
            "https://www.googleapis.com/auth/monitoring",
        ]
    }
}

resource "google_compute_firewall" "ssh" {
    name    = "ssh"
    network = google_compute_network.vpc.self_link

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
}