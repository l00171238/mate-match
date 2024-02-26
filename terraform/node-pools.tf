resource "google_service_account" "kubernetes" {
    account_id   = "kubernetes"
    display_name = "Kubernetes Engine Service Account"
}


// Create a dedicated two service account 


// firt service account for the kubernetes engine allowing to manage the cluster (DNS, Storage, etc)
resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.primary.id
  node_count = 1
  management {
    auto_repair  = true
    auto_upgrade = true
  }
  node_config {
    preemptible  = false
    machine_type = "e2-small"
    lablel {
      key = "env"
      value = "general"
      role= "general"
    }
  }
    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
    ]
}


// second service account for the kubernetes engine allowing to manage the cluster

resource "google_container_node_pool" "spot" {
    name      = "spot"
    cluster   = google_container_cluster.primary.id

    management {
        auto_repair = true
        auto_upgrade = true
    }

    autoscaling {
        min_node_count = 1
        max_node_count = 2
    }

    node_config {
        preemptible  = true
        machine_type = "e2-small"
        service_account = google_service_account.kubernetes.email
        oauth_scopes = [
            "https://www.googleapis.com/auth/cloud-platform"
        ]

        lablel {
            team = "DevOps"
        }
    }

    taint {
        key    = "instane-type"
        value  = "spot"
        effect = "NO_SCHEDULE"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
    ]

}