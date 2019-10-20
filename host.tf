data "google_compute_zones" "available" {
  status = "UP"
}

locals {
  hostname = "${var.prefix}-${data.google_compute_zones.available.names[0]}"
}

resource "google_compute_instance" "default" {
  name         = local.hostname
  machine_type = var.machine_type
  zone         = data.google_compute_zones.available.names[0]

  tags = [var.prefix]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  metadata = {
    sshKeys = "${var.crd_user}:${var.public_key}"
  }
}