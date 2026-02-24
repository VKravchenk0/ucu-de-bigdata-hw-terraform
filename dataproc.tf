resource "google_dataproc_cluster" "this" {
  name    = var.cluster_name
  region  = var.region
  project = var.project_id

  cluster_config {

    staging_bucket = google_storage_bucket.dataproc_staging.name

    gce_cluster_config {
      zone         = var.zone
      tags = ["ssh"]
    }

    master_config {
      num_instances = 1
      machine_type  = "e2-standard-2"
      disk_config {
        boot_disk_size_gb = 100
        num_local_ssds = 0
      }
    }

    worker_config {
      num_instances = 2
      machine_type  = "e2-standard-2"
      disk_config {
        boot_disk_size_gb = 100
        num_local_ssds = 0
      }
    }

    software_config {
      image_version = "2.2-debian12"

      optional_components = [
        "ZEPPELIN"
      ]
    }

    endpoint_config {
      enable_http_port_access = true
    }
  }

  depends_on = [
    google_compute_firewall.allow_ssh
  ]
}
