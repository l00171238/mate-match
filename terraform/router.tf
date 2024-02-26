//define route to access the internet for pulling image from Docker hub 

resource "google_compute_router" "router" {
  name    = "router"
  region  = "europe-west1"
  network = google_compute_network.main.id
}
