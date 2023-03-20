# terraformの設定
terraform {
  backend {}
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.56.0"
    }
  }
}

# terraformで利用するプロバイダーの設定
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
