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

variable "members" {
  description = "List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email}"
  type        = list(string)
}

variable "project" {
  description = "Project ID where to set up the instance and IAP tunneling"
}

variable "instance" {
  description = "Name of the example VM instance to create and allow SSH from IAP."
}

variable "region" {
  description = "Region to create the subnet and example VM."
  default     = "us-west1"
}

variable "zone" {
  description = "Zone of the example VM instance to create and allow SSH from IAP."
  default     = "us-west1-a"
}
