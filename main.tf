/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************
  Locals configuration
 *****************************************/
locals {
  default_bastion_name = "${var.network_name}-bastion"
  bastion_name         = "${var.bastion_instance_name != "" ? var.bastion_instance_name : local.default_bastion_name}"
  random_suffix        = "${random_string.random_four.result}"
}

/******************************************
  Bastion configuration
 *****************************************/
resource "google_compute_instance" "bastion" {
  name         = "${local.bastion_name}"
  project      = "${var.project_id}"
  machine_type = "${var.bastion_machine_type}"
  zone         = "${var.bastion_zone}"
  depends_on   = ["google_service_account.bastion_service_account"]

  metadata {
    //ssh-keys = "${var.user}:${file("${var.ssh_key}")}"
  }

  boot_disk {
    initialize_params {
      image = "${var.bastion_image}"
      size  = "${var.bastion_disk_size}"
    }
  }

  network_interface {
    subnetwork = "${var.network_subnet}"

    access_config {
      // Ephemeral IP 
    }
  }

  service_account {
    email  = "${google_service_account.bastion_service_account.email}"
    scopes = ["userinfo-email", "compute-rw", "storage-ro"]
  }
}

/******************************************
  Random string generator for ids
 *****************************************/
resource "random_string" "random_four" {
  length  = 4
  lower   = true
  upper   = false
  special = false
}

/******************************************
  Firewall rule configuration
 *****************************************/
resource "google_compute_firewall" "bastion_firewall" {
  name       = "${var.bastion_firewall_name}"
  network    = "${var.network_name}"
  depends_on = ["google_service_account.bastion_service_account"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges           = ["${var.ipv4_cidr_range}"]
  target_service_accounts = ["${google_service_account.bastion_service_account.email}"]
}
