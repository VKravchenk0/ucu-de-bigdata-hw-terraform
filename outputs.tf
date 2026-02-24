output "cluster_name" {
  value = google_dataproc_cluster.this.name
}

output "staging_bucket" {
  value = google_storage_bucket.dataproc_staging.name
}
