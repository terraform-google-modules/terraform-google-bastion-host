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

variable "host_project" {
  description = "The network host project ID."
  default     = ""
}

variable "project" {
  description = "The project ID to deploy to."
}

variable "fw_name_allow_ssh_from_iap" {
  description = "Firewall rule name for allowing SSH from IAP."
  default     = "allow-ssh-from-iap-to-tunnel"
}

variable "network" {
  description = "Self link of the network to attach the firewall to."
}

variable "service_accounts" {
  description = "Service account emails associated with the instances to allow SSH from IAP. Exactly one of service_accounts or network_tags should be specified."
  type        = list(string)
  default     = []
}

variable "network_tags" {
  description = "Network tags associated with the instances to allow SSH from IAP. Exactly one of service_accounts or network_tags should be specified."
  type        = list(string)
  default     = []
}

variable "instances" {
  type = list(object({
    name = string
    zone = string
  }))
  description = "Names and zones of the instances to allow SSH from IAP."
}

variable "members" {
  description = "List of IAM resources to allow using the IAP tunnel."
  type        = list(string)
}

variable "additional_ports" {
  description = "A list of additional ports/ranges to open access to on the instances from IAP."
  type        = list(string)
  default     = []
}
