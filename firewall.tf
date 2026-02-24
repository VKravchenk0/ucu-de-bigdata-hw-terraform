resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-dataproc"
  project = var.project_id
  network = "default"

  direction     = "INGRESS"
  priority      = 1000
  source_ranges = [var.ssh_source_ip]
  target_tags   = ["ssh"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  description = "Allow SSH to Dataproc nodes from a specific IP"
}
