provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app-network" {
  source                  = "../modules/vpc"
  app-network             = "${var.app-network}"
  app-subnetwork-name     = "${var.app-subnetwork-name}"
  app-subnetwork-ip-range = "${var.app-subnetwork-ip-ranges}"
  source-ip-ranges        = "${var.source-ip-ranges}"
}

module "db" {
  source           = "../modules/db"
  instance_name    = "db"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  db_disk_image    = "${var.db_disk_image}"
  app-network      = "${module.app-network.app_network}"
  app-subnetwork   = "${module.app-network.app_subnetwork}"
}

module "app" {
  source           = "../modules/app"
  instance_name    = "app"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  app_disk_image   = "${var.app_disk_image}"
  app-network      = "${module.app-network.app_network}"
  app-subnetwork   = "${module.app-network.app_subnetwork}"
  db-address       = "${module.db.db-address}"
}
