resource "google_compute_router_nat" "nat" {
  name         = "nat"
  router       = google_compute_router.router.name
  region       = "europe-west1"
  nat_ip_allocate_option = "MANUAL_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"


// define the NAT configuration specifying the subnet to NAT
  subnetwork {
    name = google_compute_subnetwork.private.id 
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    }

nat_ip {
    name = google_compute_address.nat.self.link
    }
}
resource "google_compute_address" "nat" {
  name = "nat"
  region = "europe-west1"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  
  depends_on = [google_compute_router_nat.nat]
}

