terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.4.0"
    }
  }

  backend "gcs" {
    bucket  = var.tf_state_bucket_name
    prefix  = "dataproc/cluster"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
