variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "staging_bucket_name" {
  description = "GCS bucket for Dataproc staging"
  type        = string
}

variable "cluster_name" {
  description = "Dataproc cluster name"
  type        = string
}

variable "ssh_source_ip" {
  description = "Public IP allowed to SSH (CIDR, e.g. 1.2.3.4/32)"
  type        = string
}
