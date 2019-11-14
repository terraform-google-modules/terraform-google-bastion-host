/**
 * Copyright 2019 Google LLC
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
  Project role id suffix configuration
 *****************************************/
resource "random_id" "random_role_id_suffix" {
  byte_length = 2
}

locals {
  base_role_id = "osLoginProjectGet"
  temp_role_id = var.random_role_id ? format(
    "%s-%s",
    local.base_role_id,
    random_id.random_role_id_suffix.hex,
  ) : local.base_role_id
}

resource "google_service_account" "bastion_host" {
  project      = var.project
  account_id   = "bastion"
  display_name = "Service Account for Bastion"
}

module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "1.1.0"

  project_id   = var.project
  machine_type = var.machine_type
  subnetwork   = var.subnet
  service_account = {
    email  = google_service_account.bastion_host.email
    scopes = var.scopes
  }
  enable_shielded_vm   = var.shielded_vm
  source_image_family  = var.image_family
  source_image_project = var.image_project
  startup_script       = var.startup_script

  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_instance_from_template" "bastion_vm" {
  name    = var.name
  project = var.project
  zone    = var.zone

  network_interface {
    subnetwork = var.subnet
  }

  source_instance_template = module.instance_template.self_link
}

resource "google_compute_firewall" "allow_from_iap_to_bastion" {
  project = var.host_project != "" ? var.host_project : var.project
  name    = "allow-ssh-from-iap-to-tunnel"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # https://cloud.google.com/iap/docs/using-tcp-forwarding#before_you_begin
  # This is the netblock needed to forward to the instances
  source_ranges           = ["35.235.240.0/20"]
  target_service_accounts = [google_service_account.bastion_host.email]
}

resource "google_iap_tunnel_instance_iam_binding" "enable_iap" {
  provider = "google-beta"
  project  = var.project
  zone     = var.zone
  instance = google_compute_instance_from_template.bastion_vm.name
  role     = "roles/iap.tunnelResourceAccessor"
  members  = var.members
}

resource "google_service_account_iam_binding" "bastion_sa_user" {
  service_account_id = google_service_account.bastion_host.id
  role               = "roles/iam.serviceAccountUser"
  members            = var.members
}

resource "google_project_iam_member" "bastion_sa_bindings" {
  for_each = toset(compact(concat(
    var.service_account_roles,
    var.service_account_roles_supplemental,
    ["projects/${var.project}/roles/${local.temp_role_id}"]
  )))

  project = var.project
  role    = each.key
  member  = "serviceAccount:${google_service_account.bastion_host.email}"
}

# If you are practicing least privilege, to enable instance level OS Login, you
# still need the compute.projects.get permission on the project level. The other
# predefined roles grant additional permissions that aren't needed
resource "google_project_iam_custom_role" "compute_os_login_viewer" {
  project     = var.project
  role_id     = local.temp_role_id
  title       = "OS Login Project Get Role"
  description = "From Terraform: iap-bastion module custom role for more fine grained scoping of permissions"
  permissions = ["compute.projects.get"]
}
