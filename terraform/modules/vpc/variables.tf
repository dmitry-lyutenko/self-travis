variable "app-network" {
  description = "App network"
}

variable "app-subnetwork-name" {
  description = "App subnetwork name"
}

variable "app-subnetwork-ip-range" {
  description = "App subnetwork ip range"
}

variable "source-ip-ranges" {
  description = "List of allowed src ip-addresses"
  default     = ["0.0.0.0/0"]
}
