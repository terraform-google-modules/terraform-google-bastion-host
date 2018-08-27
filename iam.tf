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
  Service Account configuration
 *****************************************/
resource "google_service_account" "bastion_service_account" {
  project      = "${var.project_id}"
  account_id   = "cloud-foundation-bastion-${local.random_suffix}"
  display_name = "Bastion Host Service Account"
}

/******************************************
  Granting Instance Admin Role
 *****************************************/
resource "google_project_iam_member" "instanceAdmin" {
  project    = "${var.project_id}"
  role       = "roles/compute.instanceAdmin.v1"
  member     = "serviceAccount:${google_service_account.bastion_service_account.email}"
  depends_on = ["google_service_account.bastion_service_account"]
}

/******************************************
  Granting Service Account User Role
 *****************************************/
resource "google_project_iam_member" "serviceAccountUser" {
  project    = "${var.project_id}"
  role       = "roles/iam.serviceAccountUser"
  member     = "serviceAccount:${google_service_account.bastion_service_account.email}"
  depends_on = ["google_service_account.bastion_service_account"]
}
