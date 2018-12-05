terraform {
  backend "gcs" {
    bucket = "otus-hw-tf-prod"
    prefix = "tf/state"
  }
}
