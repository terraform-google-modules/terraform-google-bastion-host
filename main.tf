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

/******************************************
  Project role id suffix configuration
 *****************************************/
resource "random_id" "random_role_id_suffix" {
  byte_length = 2
}

locals {
  base_role_id          = "osLoginProjectGet"
  service_account_email = var.service_account_email == "" ? try(google_service_account.bastion_host[0].email, "") : var.service_account_email
  service_account_roles = var.service_account_email == "" ? toset(compact(concat(
    var.service_account_roles,
    var.service_account_roles_supplemental,
  ))) : []
  temp_role_id = var.random_role_id ? format(
    "%s_%s",
    local.base_role_id,
    random_id.random_role_id_suffix.hex,
  ) : local.base_role_id
}

resource "google_service_account" "bastion_host" {
  count        = var.service_account_email == "" ? 1 : 0
  project      = var.project
  account_id   = var.service_account_name
  display_name = "Service Account for Bastion"
}

module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "~> 8.0"

  name_prefix         = var.name_prefix
  project_id          = var.project
  machine_type        = var.machine_type
  disk_size_gb        = var.disk_size_gb
  disk_type           = var.disk_type
  disk_labels         = var.disk_labels
  subnetwork          = var.subnet
  subnetwork_project  = var.host_project
  additional_networks = var.additional_networks
  region              = var.region

  service_account = {
    email  = local.service_account_email
    scopes = var.scopes
  }
  enable_shielded_vm   = var.shielded_vm
  source_image         = var.image
  source_image_family  = var.image_family
  source_image_project = var.image_project
  startup_script       = var.startup_script
  preemptible          = var.preemptible

  tags   = var.tags
  labels = var.labels

  metadata = merge(
    var.metadata,
    {
      enable-oslogin = "TRUE"
    }
  )
}

resource "google_compute_instance_from_template" "bastion_vm" {
  count   = var.create_instance_from_template ? 1 : 0
  name    = var.name
  project = var.project
  zone    = var.zone
  labels  = var.labels

  network_interface {
    subnetwork         = var.subnet
    subnetwork_project = var.host_project != "" ? var.host_project : var.project
    access_config      = var.external_ip ? var.access_config : []
  }

  source_instance_template = module.instance_template.self_link
}

module "iap_tunneling" {
  source = "./modules/iap-tunneling"

  host_project               = var.host_project
  project                    = var.project
  additional_ports           = var.additional_ports
  fw_name_allow_ssh_from_iap = var.fw_name_allow_ssh_from_iap
  network                    = var.network
  service_accounts           = [local.service_account_email]
  instances = var.create_instance_from_template ? [{
    name = try(google_compute_instance_from_template.bastion_vm[0].name, "")
    zone = var.zone
  }] : []
  members              = var.members
  create_firewall_rule = var.create_firewall_rule
}

resource "google_service_account_iam_binding" "bastion_sa_user" {
  count              = var.service_account_email == "" ? 1 : 0
  service_account_id = google_service_account.bastion_host[0].id
  role               = "roles/iam.serviceAccountUser"
  members            = var.members
}

resource "google_project_iam_member" "bastion_sa_bindings" {
  for_each = local.service_account_roles

  project = var.project
  role    = each.key
  member  = "serviceAccount:${local.service_account_email}"
}

# If you are practicing least privilege, to enable instance level OS Login, you
# still need the compute.projects.get permission on the project level. The other
# predefined roles grant additional permissions that aren't needed
resource "google_project_iam_custom_role" "compute_os_login_viewer" {
  count       = var.service_account_email == "" ? 1 : 0
  project     = var.project
  role_id     = local.temp_role_id
  title       = "OS Login Project Get Role"
  description = "From Terraform: iap-bastion module custom role for more fine grained scoping of permissions"
  permissions = ["compute.projects.get"]
}

resource "google_project_iam_member" "bastion_oslogin_bindings" {
  count   = var.service_account_email == "" ? 1 : 0
  project = var.project
  role    = "projects/${var.project}/roles/${google_project_iam_custom_role.compute_os_login_viewer[0].role_id}"
  member  = "serviceAccount:${local.service_account_email}"
}
