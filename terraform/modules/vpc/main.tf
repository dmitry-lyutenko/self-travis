resource "google_compute_network" "my-vpc" {
  name                    = "${var.app-network}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "my-subnet" {
  name          = "${var.app-subnetwork-name}"
  ip_cidr_range = "${var.app-subnetwork-ip-range}"
  network       = "${google_compute_network.my-vpc.self_link}"
}

resource "google_compute_firewall" "firewall_ssh" {
  depends_on    = ["google_compute_network.my-vpc"]
  name          = "default-allow-ssh"
  network       = "${google_compute_network.my-vpc.name}"
  source_ranges = "${var.source-ip-ranges}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
