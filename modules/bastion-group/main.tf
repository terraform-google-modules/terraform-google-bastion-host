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
  source                             = "../.."
  image_family                       = var.image_family
  image_project                      = var.image_project
  tags                               = var.tags
  labels                             = var.labels
  machine_type                       = var.machine_type
  members                            = var.members
  name                               = var.name
  network                            = var.network
  project                            = var.project
  host_project                       = var.host_project
  scopes                             = var.scopes
  service_account_name               = var.service_account_name
  service_account_email              = var.service_account_email
  service_account_roles              = var.service_account_roles
  service_account_roles_supplemental = var.service_account_roles_supplemental
  shielded_vm                        = var.shielded_vm
  startup_script                     = var.startup_script
  subnet                             = var.subnet
  additional_networks                = var.additional_networks
  zone                               = var.zone
  random_role_id                     = var.random_role_id
  fw_name_allow_ssh_from_iap         = var.fw_name_allow_ssh_from_iap
  create_instance_from_template      = false
  metadata                           = var.metadata
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "~> 8.0"

  project_id        = var.project
  region            = var.region
  target_size       = var.target_size
  hostname          = var.name
  health_check      = var.health_check
  instance_template = module.iap_bastion.instance_template
}

resource "google_compute_firewall" "allow_from_iap_to_bastion" {
  project = var.host_project != "" ? var.host_project : var.project
  name    = var.fw_name_allow_ssh_from_health_check_cidrs
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow access to the bastion instances from the Health Check endpoints
  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]
  target_service_accounts = [module.iap_bastion.service_account]
}

# TODO: Currently gcloud compute start-iap-tunnel does not support
# anything but instances. Add in ILB code when b/147258412 is fixed.
# (2020-01-07) Ryan Canty
