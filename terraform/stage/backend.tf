terraform {
  backend "gcs" {
    bucket = "otus-hw-tf-stage"
    prefix = "tf/state"
  }
}
