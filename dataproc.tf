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

      # Pre-configure the Kafka connector + GCP auth handler as cluster-wide
      # Spark packages so every job (spark-submit, Zeppelin, gcloud jobs submit)
      # can reach Managed Kafka without extra --jars flags.
      #
      # Packages are resolved from Maven Central on first job start.
      # spark-sql-kafka version must match the Spark version on image 2.2 (Spark 3.5).
      override_properties = {
        "spark:spark.jars.packages" = "org.apache.spark:spark-sql-kafka-0-10_2.12:3.5.0,com.google.cloud.hosted.kafka:managed-kafka-auth-login-handler:1.0.6",
        "spark:spark.jars.repositories" = "https://packages.confluent.io/maven/"
      }
    }

    endpoint_config {
      enable_http_port_access = true
    }
  }

  depends_on = [
    google_compute_firewall.allow_ssh,
    google_managed_kafka_cluster.this,
  ]
}
