# Compute instance
resource "google_compute_instance" "session_instance" {
  name         = "gdg-session-demo"
  machine_type = "e2-medium"
  zone         = "asia-south1-a"

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
    ssh-keys = "piush:${file("~/.ssh/id_rsa_another.pub")}"
  }
}
