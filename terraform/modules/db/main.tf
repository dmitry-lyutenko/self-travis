resource "google_compute_instance" "db" {
  name         = "${var.instance_name}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-db"]

  # boot HDD
  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    #network       = "${var.app-network}"
    subnetwork    = "${var.app-subnetwork}"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file("${var.public_key_path}")}"
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file("${var.private_key_path}")}"
  }
/*
  provisioner "remote-exec" {
    inline = [
      "sudo sed -i 's/^.*bindIp.*$//' /etc/mongod.conf",
      "sudo systemctl restart mongod.service"
    ]
  }
*/  
}

resource "google_compute_firewall" "firewall_mongo" {
  name        = "allow-mongo-${var.app-network}"
  network     = "${var.app-network}"
  source_tags = ["reddit-app"]
  target_tags = ["reddit-db"]
  source_ranges = ["0.0.0.0/0"]
  
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }
}
