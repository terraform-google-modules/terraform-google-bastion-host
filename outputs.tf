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

output "private_ip" {
  value       = "${google_compute_instance.bastion.network_interface.0.address}"
  description = "Private IP address of the bastion host"
}

output "public_ip" {
  value       = "${google_compute_instance.bastion.network_interface.0.access_config.0.assigned_nat_ip}"
  description = "Public IP address of the bastion host:"
}

output "service_account" {
  value       = "${google_service_account.bastion_service_account.email}"
  description = "Newly created service account email"
}

output "firewall_name" {
  value       = "${google_compute_firewall.bastion_firewall.name}"
  description = "Newly created firewall rule "
}

output "network_name" {
  value       = "${var.network_name}"
  description = "Network of the bastion host"
}

output "bastion_name" {
  value       = "${var.bastion_instance_name}"
  description = "Name of the  bastion host"
}

output "bastion_zone" {
  value       = "${var.bastion_zone}"
  description = "Zone of the bastion host"
}

output "bastion_project" {
  value       = "${var.project_id}"
  description = "Project ID for the bastion host"
}
