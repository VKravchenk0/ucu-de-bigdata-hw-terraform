resource "google_storage_bucket" "dataproc_staging" {
  name     = var.staging_bucket_name
  location = var.region
  project  = var.project_id

  uniform_bucket_level_access = true
  force_destroy               = true
}
