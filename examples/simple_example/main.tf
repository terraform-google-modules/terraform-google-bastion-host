/**
 * Copyright 2021 Google LLC
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

module "iap_bastion" {
  source  = "terraform-google-modules/bastion-host/google"
  version = "~> 6.0"

  project = var.project_id
  zone    = "us-west1-a"
  network = google_compute_network.network.self_link
  subnet  = google_compute_subnetwork.subnet.self_link
  members = var.members
  disk_labels = {
    "test-label" = "test-value"
  }
}

resource "google_compute_network" "network" {
  project                 = var.project_id
  name                    = "test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  project                  = var.project_id
  name                     = "test-subnet"
  region                   = "us-west1"
  ip_cidr_range            = "10.127.0.0/20"
  network                  = google_compute_network.network.self_link
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_access_from_bastion" {
  project = var.project_id
  name    = "allow-bastion-ssh"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow SSH only from IAP Bastion
  source_service_accounts = [module.iap_bastion.service_account]
}
