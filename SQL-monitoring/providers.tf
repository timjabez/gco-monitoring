terraform {
  required_version = ">= 1.4.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.6.0, < 6.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.6.0, < 6.0.0"
    }
  }
}

provider "google" {
  project = "vivid-ocean-386206"
  impersonate_service_account = "sa-github-actions@vivid-ocean-386206.iam.gserviceaccount.com"
  #   region  = "asia-south1"
}
