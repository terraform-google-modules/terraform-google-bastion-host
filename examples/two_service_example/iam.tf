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

resource "google_service_account" "service_a" {
  project      = var.project
  account_id   = "service-a"
  display_name = "Service Account for Service A"
}

resource "google_service_account" "service_b" {
  project      = var.project
  account_id   = "service-b"
  display_name = "Service Account for Service B"
}

resource "google_compute_instance_iam_member" "alice_oslogin_1" {
  project       = var.project
  zone          = var.zone
  instance_name = google_compute_instance.priv_host_a_1.name
  role          = "roles/compute.osLogin"
  member        = var.user_a
}

resource "google_compute_instance_iam_member" "alice_oslogin_2" {
  project       = var.project
  zone          = var.zone
  instance_name = google_compute_instance.priv_host_a_2.name
  role          = "roles/compute.osLogin"
  member        = var.user_a
}

resource "google_service_account_iam_member" "gce_default_account_iam" {
  service_account_id = google_service_account.service_a.id
  role               = "roles/iam.serviceAccountUser"
  member             = var.user_a
}

resource "google_compute_instance_iam_member" "bdole_oslogin" {
  project       = var.project
  zone          = var.zone
  instance_name = google_compute_instance.priv_host_b_1.name
  role          = "roles/compute.osLogin"
  member        = var.user_b
}

resource "google_service_account_iam_member" "bdole_use_sa" {
  service_account_id = google_service_account.service_b.id
  role               = "roles/iam.serviceAccountUser"
  member             = var.user_b
}
