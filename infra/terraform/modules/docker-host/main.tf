resource "google_compute_instance" "docker-host" {
  name         = "gitlab-ci-${count.index}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  count        = "${var.instance_count}"
  tags         = ["docker-host", "http-server", "https-server"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
      size  = "${var.disk_size}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}


resource "google_compute_firewall" "firewall_puma" {
  name    = "firewall-puma"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["docker-host"]
}
