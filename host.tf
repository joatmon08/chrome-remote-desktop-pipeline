data "google_compute_zones" "available" {
  status = "UP"
}

data "google_compute_image" "crd_image" {
  family  = "crd-debian-9"
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
      image = data.google_compute_image.crd_image.self_link
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