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
output "service_account" {
  description = "The email for the service account created for the bastion host"
  value       = local.service_account_email
}

output "hostname" {
  description = "Host name of the bastion"
  value       = var.name
}

output "ip_address" {
  description = "Internal IP address of the bastion host"
  value       = try((var.create_instance_from_template ? google_compute_instance_from_template.bastion_vm[0].network_interface.0.network_ip : ""), "")
}

output "self_link" {
  description = "Self link of the bastion host"
  value       = try((var.create_instance_from_template ? google_compute_instance_from_template.bastion_vm[0].self_link : ""), "")
}

output "instance_template" {
  description = "Self link of the bastion instance template for use with a MIG"
  value       = module.instance_template.self_link
}
