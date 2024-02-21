resource "google_compute_router_nat" "nat" {
  name         = "nat"
  router       = google_compute_router.router.name
  region       = var.region
  nat_ip_allocate_option = "MANUAL_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  subnetwork {
    name = google_compute_subnetwork.private.id }
}