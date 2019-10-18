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

provider "google-beta" {}

resource "google_service_account" "bastion_host" {
  project      = var.project
  account_id   = "bastion"
  display_name = "Service Account for Bastion"
}

resource "google_compute_instance" "bastion_vm" {
  project      = var.project
  zone         = var.zone
  name         = var.name
  machine_type = var.machine_type
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = var.image
    }
  }
  scratch_disk {}

  network_interface {
    subnetwork = var.subnet
  }

  service_account {
    email  = google_service_account.bastion_host.email
    scopes = var.scopes
  }

  metadata_startup_script = var.startup_script
  metadata = {
    enable-oslogin = "TRUE"
  }

  shielded_instance_config {
    enable_secure_boot          = var.shielded_vm
    enable_vtpm                 = var.shielded_vm
    enable_integrity_monitoring = var.shielded_vm
  }
}

resource "google_compute_firewall" "allow_from_iap_to_bastion" {
  project = var.project
  name    = "allow-ssh-from-iap-to-tunnel"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # https://cloud.google.com/iap/docs/using-tcp-forwarding#before_you_begin
  # This is the netblock needed to forward to the instances
  source_ranges = ["35.235.240.0/20"]
  target_service_accounts = [google_service_account.bastion_host.email]
}

resource "google_iap_tunnel_instance_iam_binding" "enable_iap" {
  provider = "google-beta"
  project  = var.project
  zone     = var.zone
  instance = google_compute_instance.bastion_vm.name
  role     = "roles/iap.tunnelResourceAccessor"
  members  = var.members
}

resource "google_service_account_iam_binding" "bastion_sa_user" {
  service_account_id = google_service_account.bastion_host.id
  role               = "roles/iam.serviceAccountUser"
  members            = var.members
}

resource "google_project_iam_binding" "bastion_sa_bindings" {
  for_each  = toset(compact(concat(
    var.service_account_roles,
    var.service_account_roles_supplemental,
    ["projects/${var.project}/roles/${google_project_iam_custom_role.compute_os_login_viewer.role_id}"]
  )))

  project   = var.project
  role      = each.key
  members   = ["serviceAccount:${google_service_account.bastion_host.email}"]
}

# If you are practicing least privilege, to enable instance level OS Login, you
# still need the compute.projects.get permission on the project level. The other
# predefined roles grant additional permissions that aren't needed
resource "google_project_iam_custom_role" "compute_os_login_viewer" {
  project     = var.project
  role_id     = "osLoginProjectGet"
  title       = "OS Login Project Get Role"
  description = "From Terraform: iap-bastion module custom role for more fine grained scoping of permissions"
  permissions = ["compute.projects.get"]
}