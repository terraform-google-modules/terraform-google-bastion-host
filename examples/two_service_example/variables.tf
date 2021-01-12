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

variable "project" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "network" {
  description = "Self link for the VPC network"
  type        = string
}

variable "subnet" {
  description = "Self link for the Subnet within var.network"
  type        = string
}

variable "user_a" {
  description = "User in the IAM policy format of user:{email}"
}

variable "user_b" {
  description = "User in the IAM policy format of user:{email}"
}

variable "zone" {
  default = "us-west1-a"
}
