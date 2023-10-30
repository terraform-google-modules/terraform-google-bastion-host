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
variable "target_size" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "image_family" {
  description = "Source image family for the Bastion."
  type        = string
  default     = "debian-11"
}

variable "image_project" {
  description = "Project where the source image for the Bastion comes from"
  type        = string
  default     = "debian-cloud"
}

variable "tags" {
  type        = list(string)
  description = "Network tags, provided as a list"
  default     = []
}

variable "labels" {
  description = "Key-value map of labels to assign to the bastion host"
  type        = map(any)
  default     = {}
}

variable "machine_type" {
  description = "Instance type for the Bastion host"
  type        = string
  default     = "n1-standard-1"
}

variable "members" {
  description = "List of IAM resources to allow access to the bastion host"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name prefix of bastion instances"
  type        = string
  default     = "bastion"
}

variable "network" {
  description = "Self link for the network on which the Bastion should live"
  type        = string
}

variable "project" {
  description = "The project ID to deploy to"
  type        = string
}

variable "health_check" {
  description = "Health check config for the mig."
  type = object({
    type                = string
    initial_delay_sec   = number
    check_interval_sec  = number
    healthy_threshold   = number
    timeout_sec         = number
    unhealthy_threshold = number
    response            = string
    proxy_header        = string
    port                = number
    request             = string
    enable_logging      = bool

    # Unused fields.
    request_path = string
    host         = string
  })
  default = {
    type                = "tcp"
    initial_delay_sec   = 30
    check_interval_sec  = 30
    healthy_threshold   = 1
    timeout_sec         = 10
    unhealthy_threshold = 5
    response            = ""
    proxy_header        = "NONE"
    port                = 22
    request             = ""
    enable_logging      = false

    # Unused fields.
    request_path = ""
    host         = ""
  }
}

variable "host_project" {
  description = "The network host project ID"
  type        = string
  default     = ""
}

variable "region" {
  description = "The primary region where the bastion host will live"
  type        = string
  default     = "us-central1"
}

variable "scopes" {
  description = "List of scopes to attach to the bastion host"
  type        = list(string)
  default     = ["cloud-platform"]
}

variable "service_account_roles" {
  description = "List of IAM roles to assign to the service account."
  type        = list(string)
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/compute.osLogin",
  ]
}

variable "service_account_roles_supplemental" {
  description = "An additional list of roles to assign to the bastion if desired"
  type        = list(string)
  default     = [""]
}

variable "service_account_name" {
  description = "Account ID for the service account"
  type        = string
  default     = "bastion-group"
}

variable "service_account_email" {
  description = "If set, the service account and its permissions will not be created. The service account being passed in should have at least the roles listed in the parent module `service_account_roles` variable so that logging and OS Login work as expected."
  default     = ""
  type        = string
}

variable "shielded_vm" {
  description = "Enable shielded VM on the bastion host (recommended)"
  default     = true
  type        = bool
}

variable "startup_script" {
  description = "Render a startup script with a template."
  type        = string
  default     = ""
}

variable "subnet" {
  description = "Self link for the subnet on which the Bastion should live. Can be private when using IAP"
  type        = string
}

variable "zone" {
  description = "The primary zone where the bastion host will live"
  type        = string
  default     = "us-central1-a"
}

variable "random_role_id" {
  description = "Enables role random id generation."
  type        = bool
  default     = true
}

variable "fw_name_allow_ssh_from_health_check_cidrs" {
  description = "Firewall rule name for allowing Health Checks"
  type        = string
  default     = "allow-ssh-from-health-check-cidrs"
}

variable "fw_name_allow_ssh_from_iap" {
  description = "Firewall rule name for allowing SSH from IAP"
  type        = string
  default     = "allow-ssh-from-iap-to-bastion-group"
}

variable "additional_networks" {
  description = "Additional network interface details for the instance template, if any."
  default     = []
  type = list(object({
    network            = string
    subnetwork         = string
    subnetwork_project = string
    network_ip         = string
    nic_type           = string
    stack_type         = string
    queue_count        = number
    access_config = list(object({
      nat_ip       = string
      network_tier = string
    }))
    ipv6_access_config = list(object({
      network_tier = string
    }))
    alias_ip_range = list(object({
      ip_cidr_range         = string
      subnetwork_range_name = string
    }))
  }))
}

variable "metadata" {
  type        = map(string)
  description = "Key-value map of additional metadata to assign to the instances"
  default     = {}
}
