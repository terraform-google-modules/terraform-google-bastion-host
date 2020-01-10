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

resource "google_service_account" "vm_sa" {
  project      = var.project
  account_id   = var.instance
  display_name = "Service Account for VM"
}

# A testing VM to allow OS Login + IAP tunneling.
module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "1.1.0"

  project_id   = var.project
  machine_type = "n1-standard-1"
  network      = "default"
  service_account = {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }
  metadata = {
    enable-oslogin = "TRUE"
  }
}

resource "google_compute_instance_from_template" "vm" {
  name    = var.instance
  project = var.project
  zone    = var.zone
  network_interface {
    network = "default"
  }
  source_instance_template = module.instance_template.self_link
}

# Additional OS login IAM bindings.
# https://cloud.google.com/compute/docs/instances/managing-instance-access#granting_os_login_iam_roles
resource "google_service_account_iam_binding" "sa_user" {
  service_account_id = google_service_account.vm_sa.id
  role               = "roles/iam.serviceAccountUser"
  members            = var.members
}

resource "google_project_iam_member" "os_login_bindings" {
  for_each = toset(var.members)
  project  = var.project
  role     = "roles/compute.osLogin"
  member   = each.key
}

module "iap_tunneling" {
  source           = "../../modules/iap-tunneling"
  project          = var.project
  network          = "default"
  service_accounts = [google_service_account.vm_sa.email]
  instances = [{
    name = google_compute_instance_from_template.vm.name
    zone = var.zone
  }]
  members = var.members
}
