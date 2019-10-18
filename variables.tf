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

variable "image" {
  description = "GCE image on which to base the Bastion. This image is supported by Shielded VM"
  default = "gce-uefi-images/centos-7"
}

variable "labels" {
  type = "map"
  default = {}
}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "members" {
  type = "list"
  default = []
}
variable "name" {
  description = "Name of the Bastion instance"
  default = "bastion-vm"
}

variable "network" {
  description = "Self link for the network on which the Bastion should live"
}

variable "project" {
  description = "The project ID to deploy to"
}

variable "scopes" {
  description = "List of scopes to attach to the bastion host"
  default = ["cloud-platform"]
}

variable "service_account_roles" {
  description = "List of IAM roles to assign to the service account."
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/compute.osLogin",
  ]
}
variable "service_account_roles_supplemental" {
  description = "An additional list of roles to assign to the bastion if desired"
  default = []
}

variable "shielded_vm" {
  default = true
}
variable "startup_script" {
  description = "Render a startup script with a template."
  default = ""
}

variable "subnet" {
  description = "Self link for the subnet on which the Bastion should live. Can be private when using IAP"
}
variable "zone" {
  description = "The primary zone where the bastion host will live"
  default = "us-central1-a"
}