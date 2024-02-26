// define a cluster with network and subnetwork 
// currently logging_service is not supported in terraform

resource "google_container_cluster" "primary" {
  name                     = "my-gke-cluster"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.main.id
  subnetwork               = google_compute_subnetwork.main.id
  #   logging_service = "logging.googleapis.com/kubernetes"
  #   monitoring_service = "monitoring.googleapis.com/kubernetes"
  networking_mode = "VPC_NATIVE"

  //node locations

  node_locations = ["us-central1-a", ]


  // Addons service configuration currently off

  addons_config {

    workload_identity_config {
      disabled = "heroic-psyche-414901.svc.id.goog"
    }

    ip_allocation_policy {
      clutser_secondary_ip_range  = "k8s-pod-range"
      services_secondary_ip_range = "k8s-service-range"
    }

    private_cluster_config {
      enable_private_endpoint = false
      enable_private_nodes    = true
      master_ipv4_cidr_block  = "172.16.0.0/28"
    }

    // Use Jenkins case

    master_authorized_networks_config {
      cidr_blocks = {
        cidr_block = "10.0.0.0/18"
        display_name = "private-subnet-jenkins"
      }
    }

    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    kubernetes_dashboard {
      disabled = false
    }
    network_policy_config {
      disabled = false
    }


  }

  node_config {
    machine_type = "n1-standard-1"
    disk_size_gb = 100
  }

  depends_on = [google_compute_network.main, google_compute_subnetwork.main]
}