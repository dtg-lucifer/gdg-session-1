# Compute instance
resource "google_compute_instance" "session_instance" {
  name         = "gdg-session-demo"
  machine_type = "e2-medium"
  zone         = "asia-south1-a"

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    # use the default vpc
    network = "default"

    access_config {}
  }

  metadata = {
    ssh-keys       = "piush:${file("~/.ssh/id_rsa_another.pub")}"
    startup-script = "${file("../scripts/startup.sh")}"
  }
}

# firewall to allow only http and https
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"] # Allow traffic from anywhere
  target_tags   = ["http-server", "https-server"]
}
