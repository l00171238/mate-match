resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  vpc     = "main"
  network = google_compute_network.vpc.main

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}