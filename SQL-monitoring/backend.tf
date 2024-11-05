terraform {
  # https://developer.hashicorp.com/terraform/language/settings/backends/gcs
  backend "gcs" {
    bucket                      = "github-backend-bucket"
    prefix                      = "prd"
    impersonate_service_account = "sa-github-actions@vivid-ocean-386206.iam.gserviceaccount.com"
  }
}
