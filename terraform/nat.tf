resource "google_compute_router_nat" "nat" {
  name         = "nat"
  router       = google_compute_router.router.name
  region       = var.region
  nat_ip_allocate_option = "MANUAL_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"


// define the NAT configuration specifying the subnet to NAT
  subnetwork {
    name = google_compute_subnetwork.private.id 
    source_ip_ranges_to_nat = "ALL_IP_RANGES"
    }

nat_ip {
    name = google_compute_address.nat.self.link
    }

resource "google_compute_address" "nat" {
  name = "nat"
  region = var.region
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"
  }
  depends_on = [google_compute_router_nat.nat]

}
