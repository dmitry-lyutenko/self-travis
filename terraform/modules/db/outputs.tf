output "db-address" {
  value = "${google_compute_instance.db.0.network_interface.0.access_config.0.assigned_nat_ip}"
}
