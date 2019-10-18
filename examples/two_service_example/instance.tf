resource "google_compute_instance" "priv_host_a_1" {
  project      = var.project
  zone         = var.zone
  name         = "priv-host-a-1"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = var.subnet
  }

  service_account {
    email  = google_service_account.service_a.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_instance" "priv_host_a_2" {
  project      = var.project
  zone         = var.zone
  name         = "priv-host-a-2"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = var.subnet
  }

  service_account {
    email  = google_service_account.service_a.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_instance" "priv_host_b_1" {
  project      = var.project
  zone         = var.zone
  name         = "priv-host-b-1"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = var.subnet
  }

  service_account {
    email  = google_service_account.service_b.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

