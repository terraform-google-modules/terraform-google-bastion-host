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
variable "project_id" {
  description = "Name of the project where the bastion host will be created"
}

variable "bastion_instance_name" {
  description = "Name of the GCE instance that will serve as the bastion host"
  default     = ""
}

variable "bastion_zone" {
  description = "GCE zone where the bastion host will be created"
  default     = "us-central1-a"
}

variable "bastion_machine_type" {
  description = "GCE machine type the bastion host will be created with"
  default     = "n1-standard-1"
}

variable "bastion_disk_size" {
  description = "Size of the local disk the bastion host will be created with"
  default     = "10"
}

variable "bastion_image" {
  description = "GCE image the bastion host will be created with"
  default     = "debian-cloud/debian-9"
}

variable "network_name" {
  description = "VPC network where the bastion host will be created"
  default     = "default"
}

variable "network_subnet" {
  description = "VPC subnet where the bastion host will be created"
  default     = "default"
}

variable "ipv4_cidr_range" {
  description = "The ipv4 CIDR range that is allowed to connect to the bastion host"
  type        = "list"
  default     = ["0.0.0.0/0"]
}

variable "bastion_firewall_name" {
  description = "New firewall rule name"
  default     = "bastion-firewall-rule"
}
