variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  default = "europe-west1-d"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable "instace_count" {
  description = "Number of instances in cluster"
  default     = 1
}

variable "app_port" {
  default     = 9292
  description = "Firewall and health check port"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-db-base"
}

variable "app-network" {
  description = "App network"
  default     = "my-network"
}

variable "app-subnetwork-name" {
  default = "app-subnetwork"
}

variable "app-subnetwork-ip-ranges" {
  default = "10.11.12.0/24"
}

variable "source-ip-ranges" {
  description = "Allowed connetion from"
  default     = ["0.0.0.0/0"]
}
