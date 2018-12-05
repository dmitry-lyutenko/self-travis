variable "instance_name" {
  description = "Instsnce name"
  default         = "reddit-app-db"
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

variable db_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-db-base"
}

variable "app-network" {
  description = "Network"
  default     = "default"
}

variable "app-subnetwork" {
  default = "app-subnetwork"
}
