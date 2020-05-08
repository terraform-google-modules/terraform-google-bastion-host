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

variable "image" {
  type = string

  description = "Source image for the Bastion. If image is not specified, image_family will be used (which is the default)."
  default     = ""
}

variable "image_family" {
  type = string

  description = "Source image family for the Bastion."
  default     = "centos-7"
}

variable "image_project" {
  type = string

  description = "Project where the source image for the Bastion comes from"
  default     = "gce-uefi-images"
}

variable "create_instance_from_template" {
  type = bool

  description = "Whether to create and instance from the template or not. If false, no instance is created, but the instance template is created and usable by a MIG"
  default     = true
}

variable "tags" {
  type = list(string)

  description = "Network tags, provided as a list"
  default     = []
}

variable "labels" {
  type = map

  description = "Key-value map of labels to assign to the bastion host"
  default     = {}
}

variable "machine_type" {
  type        = string
  description = "Instance type for the Bastion host"
  default     = "n1-standard-1"
}

variable "members" {
  type = list(string)

  description = "List of IAM resources to allow access to the bastion host"
  default     = []
}

variable "name" {
  type = string

  description = "Name of the Bastion instance"
  default     = "bastion-vm"
}

variable "name_prefix" {
  type = string

  description = "Name prefix for instance template"
  default     = "bastion-instance-template"
}
variable "network" {
  type = string

  description = "Self link for the network on which the Bastion should live"
}

variable "project" {
  type = string

  description = "The project ID to deploy to"
}

variable "host_project" {
  type = string

  description = "The network host project ID"
  default     = ""
}

variable "region" {
  type = string

  description = "The primary region where the bastion host will live"
  default     = "us-central1"
}

variable "scopes" {
  type = list(string)

  description = "List of scopes to attach to the bastion host"
  default     = ["cloud-platform"]
}

variable "service_account_roles" {
  type = list(string)

  description = "List of IAM roles to assign to the service account."
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/compute.osLogin",
  ]
}

variable "service_account_roles_supplemental" {
  type = list(string)

  description = "An additional list of roles to assign to the bastion if desired"
  default     = []
}

variable "service_account_name" {
  type = string

  description = "Account ID for the service account"
  default     = "bastion"
}

variable "shielded_vm" {
  type = bool

  description = "Enable shielded VM on the bastion host (recommended)"
  default     = true
}

variable "startup_script" {
  type = string

  description = "Render a startup script with a template."
  default     = ""
}

variable "subnet" {
  type = string

  description = "Self link for the subnet on which the Bastion should live. Can be private when using IAP"
}

variable "zone" {
  type = string

  description = "The primary zone where the bastion host will live"
  default     = "us-central1-a"
}

variable "random_role_id" {
  type = bool

  description = "Enables role random id generation."
  default     = true
}

variable "fw_name_allow_ssh_from_iap" {
  type = string

  description = "Firewall rule name for allowing SSH from IAP"
  default     = "allow-ssh-from-iap-to-tunnel"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  default = 10
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default = "pd-standard"
}
