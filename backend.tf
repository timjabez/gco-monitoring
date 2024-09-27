terraform {
  backend "gcs" {
    bucket  = "github-backend-bucket"
    prefix  = "terraform/state"
  }
}
provide "google" {
}
