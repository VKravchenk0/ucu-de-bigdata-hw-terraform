resource "google_project_service" "managed_kafka" {
  project            = var.project_id
  service            = "managedkafka.googleapis.com"
  disable_on_destroy = true
}

# Look up the project number (needed for subnet path and IAM)
data "google_project" "this" {
  project_id = var.project_id
}

# Grant the Dataproc default Compute Engine service account permission to
# connect to any Managed Kafka cluster in this project.
# Default SA email: <project-number>-compute@developer.gserviceaccount.com
resource "google_project_iam_member" "dataproc_kafka_client" {
  project = var.project_id
  role    = "roles/managedkafka.client"
  member  = "serviceAccount:${data.google_project.this.number}-compute@developer.gserviceaccount.com"
}

resource "google_managed_kafka_cluster" "this" {
  cluster_id = "${var.cluster_name}-kafka"
  location   = var.region
  project    = var.project_id

  capacity_config {
    vcpu_count   = 3
    memory_bytes = 3221225472
  }

  gcp_config {
    access_config {
      network_configs {
        subnet = "projects/${var.project_id}/regions/${var.region}/subnetworks/default"
      }
    }
  }

  depends_on = [
    google_project_service.managed_kafka,
    google_project_iam_member.dataproc_kafka_client,
  ]
}

resource "google_managed_kafka_topic" "fraud_detection" {
  cluster    = google_managed_kafka_cluster.this.cluster_id
  topic_id   = var.kafka_topic
  location   = var.region
  project    = var.project_id

  partition_count    = var.kafka_partitions
  replication_factor = 3

  configs = {
    "retention.ms" = "86400000"
  }

  depends_on = [google_managed_kafka_cluster.this]
}
