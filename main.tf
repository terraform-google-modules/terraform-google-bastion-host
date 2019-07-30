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

terraform {
  required_version = "~> 0.11.0"
}

provider "google-beta" {
  project = "${var.project_id}"
  zone    = "${var.zone}"
}

resource "google_service_account" "bastion_host" {
  account_id   = "bastion"
  display_name = "Service Account for Bastion"
}

resource "google_compute_instance" "bastion-vm" {
  zone         = "${var.zone}"
  name         = "bastion-vm"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "${var.subnet}"
  }

  service_account {
    email  = "${google_service_account.bastion_host.email}"
    scopes = ["cloud-platform"]
  }

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_firewall" "allow_from_bastion" {
  name    = "allow-ssh-from-bastion"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_service_accounts = ["${google_service_account.bastion_host.email}"]
}

resource "google_compute_firewall" "allow_from_iap_to_bastion" {
  name    = "allow-ssh-from-iap-to-tunnel"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # https://cloud.google.com/iap/docs/using-tcp-forwarding#before_you_begin
  # This is the netblock needed to forward to the instances
  source_ranges = ["35.235.240.0/20"]

  target_service_accounts = ["${google_service_account.bastion_host.email}"]
}

resource "google_iap_tunnel_instance_iam_binding" "enable_iap" {
  provider = "google-beta"
  project  = "${var.project_id}"
  zone     = "${var.zone}"
  instance = "${google_compute_instance.bastion-vm.name}"
  role     = "roles/iap.tunnelResourceAccessor"
  members  = "${var.members}"
}

resource "google_compute_instance_iam_binding" "enable_os_login" {
  instance_name = "${google_compute_instance.bastion-vm.name}"
  role          = "roles/compute.osLogin"
  members       = "${var.members}"
}

resource "google_service_account_iam_binding" "bastion_use_sa" {
  service_account_id = "${google_service_account.bastion_host.id}"
  role               = "roles/iam.serviceAccountUser"
  members            = "${var.members}"
}

#if you are practing least privilege, to enable instance level os login, you
#still need the compute.projects.get permission on the project level. The other
# predefined roles grant additional permissions that aren't needed
resource "google_project_iam_custom_role" "compute_os_login_viewer" {
  role_id     = "osLoginProjectGet"
  title       = "OS Login Project Get Role"
  description = "From Terraform: iap-bastion module custom role for more fine grained scoping of permissions"
  permissions = ["compute.projects.get"]
}

resource "google_project_iam_binding" "compute_os_binding" {
  role    = "projects/${var.project_id}/roles/${google_project_iam_custom_role.compute_os_login_viewer.role_id}"
  members = "${var.members}"
}
