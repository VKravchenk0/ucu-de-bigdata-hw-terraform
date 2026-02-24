output "cluster_name" {
  value = google_dataproc_cluster.this.name
}

output "staging_bucket" {
  value = google_storage_bucket.dataproc_staging.name
}

output "kafka_cluster_id" {
  description = "Managed Kafka cluster ID"
  value       = google_managed_kafka_cluster.this.cluster_id
}

output "kafka_topic" {
  description = "Kafka topic name"
  value       = google_managed_kafka_topic.fraud_detection.topic_id
}