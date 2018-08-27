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

provider "google" {
  credentials = "${file(var.credentials_file_path)}"
  project     = "${var.project_id}"
}

module "bastion-host" {
  source                = "../../"
  project_id            = "${var.project_id}"
  bastion_instance_name = "test-bastion"
  bastion_zone          = "us-central1-a"
  bastion_machine_type  = "n1-standard-1"
  bastion_disk_size     = "10"
  bastion_image         = "debian-cloud/debian-9"
  network_name          = "default"
  network_subnet        = "default"
  ipv4_cidr_range       = ["0.0.0.0/0"]
  bastion_firewall_name = "bastion-firewall-rule"
}
