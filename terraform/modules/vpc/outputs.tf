output "app_subnetwork" {
  value = "${google_compute_subnetwork.my-subnet.name}"
}

output "app_network" {
  value = "${google_compute_network.my-vpc.name}"
}
