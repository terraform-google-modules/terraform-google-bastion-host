#!bin/bash
#!/bin/bash
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


#################################################################
#   PLEASE FILL THE VARIABLES WITH VALID VALUES FOR TESTING     #
#   DO NOT REMOVE ANY OF THE VARIABLES                          #
#################################################################

export PROJECT_ID="<PROJECT_ID>"
export CREDENTIALS_PATH="<FULL_PATH_TO_CREDENTIALS_FILE>"
export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=$CREDENTIALS_PATH

# Cleans the workdir
function clean_workdir() {
  echo "Cleaning workdir"
  yes | rm -f terraform.tfstate*
  yes | rm -f *.tf
  yes | rm -rf .terraform
}

# Creates the main.tf file for Terraform
function create_main_tf_file() {
  echo "Creating main.tf file"
  touch main.tf
  cat <<EOF > main.tf

locals {
  credentials_file_path    = "$CREDENTIALS_PATH"
}

provider "google" {
  credentials              = "\${file(local.credentials_file_path)}"
  project = "$PROJECT_ID" 
}
module "bastion-host" {
  source                = "../../../"
  project_id            = "$PROJECT_ID"
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
EOF
}

# Creates the outputs.tf file
function create_outputs_file() {
  echo "Creating outputs.tf file"
  touch outputs.tf
  cat <<EOF > outputs.tf
output "bastion_project" {
  value = "\${module.bastion-host.bastion_project}"
}

output "service_account" {
  value       = "\${module.bastion-host.service_account}"
}

output "firewall_name" {
  value       = "\${module.bastion-host.firewall_name}"
}

output "network_name" {
  value       = "\${module.bastion-host.network_name}"
}

output "bastion_name" {
  value       = "\${module.bastion-host.bastion_name}"
}

output "bastion_zone" {
  value       = "\${module.bastion-host.bastion_zone}"
}

EOF
}

# Preparing environment
clean_workdir
create_main_tf_file
create_outputs_file

# Call to bats
echo "Test to execute: $(bats integration.bats -c)"
bats integration.bats

export CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE=""
unset CLOUDSDK_AUTH_CREDENTIAL_FILE_OVERRIDE

# Clean the environment
clean_workdir
echo "Integration test finished"
