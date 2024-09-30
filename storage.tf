resource "google_storage_bucket" "auto-expire" {
  name          = "no-public-access-bucket-test"
  location      = "US"
  project       = "vivid-ocean-386206"
}
