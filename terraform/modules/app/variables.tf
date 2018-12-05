variable "instance_name" {
  description = "instance name"
  default = "reddit-app"
}

variable zone {
  default = "europe-west1-d"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the public key used for ssh access"
}

variable "app_port" {
  default     = 9292
  description = "Firewall and health check port"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable "app-network" {
  description = "App netwok"
  default     = "default"
}

variable "app-subnetwork" {
  default = "app-subnetwork"
}

variable "db-address" {
  description = "Database ip address"
  default = "127.0.0.1"
}
