# Terraform Bastion Host Module

## Requirements
### Terraform plugins
- [Terraform](https://www.terraform.io/downloads.html) 0.11.x
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin v1.15.x
- [random](https://github.com/terraform-providers/terraform-provider-random) plugin 1.3.x

### Configure a Service Account
In order to execute this module with a Service Account, it must have the following:
#### Roles
The service account with the following role:
- roles/compute.instanceAdmin.v1 on the project
- roles/compute.securityAdmin on the project
- roles/iam.serviceAccountAdmin on the project
- roles/iam.serviceAccountUser on the project
- roles/resourcemanager.projectIamAdmin on the project

### Enable API's
In order to operate with the Service Account you must activate the following API on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com

## Install

### Terraform
Be sure you have the correct Terraform version (0.11.x), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

## Usage
You can go to the examples folder, however the usage of the module could be like this in your own main.tf file:

*Configure the provider here before the module invocation, see the examples folder*

```hcl
module "bastion-host" {
  source  = "../../"
  project_name = “<PROJECT ID>”
  bastion_instance_name = “example-bastion-name”
  bastion_zone = “us-central1-a”
  bastion_machine_type = “n1-standard-1”
  bastion_disk_size = “10”
  bastion_image = “debian-cloud/debian-9”
  bastion_firewall_name = "bastion-firewall-rule"
  network_name = “bastion-test”
  network_subnet = “default”
  ipv4_cidr_range = “[0.0.0.0/0]”
}
```

Then perform the following commands on the root folder:

- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

#### Variables
Please refer the /variables.tf file for the required and optional variables.

#### Outputs
Please refer the /outputs.tf file for the outputs that you can get with the `terraform output` command

## Infrastructure
The resources/services/activations/deletions that this module will create/trigger are:
- A Google Cloud Compute Engine Instance
- A Google Cloud VCP firewall rule
- A Google Cloud Service Account

The roles granted for the specific resources are:
- Service Account
  - compute.InstanceAdmin.v1 on project
  - iam.serviceAccountUser on project

## File structure
The project has the following folders and files:
- /: root folder
- /examples: examples for using this module
- /test: Folders with files for testing the module (see Testing section on this file)
- /iam.tf: iam file for this module, contains all iam resources
- /main.tf: main file for this module, contains all resources excempt iam
- /variables.tf: all the variables for the module
- /output.tf: the outputs of the module
- /README.md: this file

## Testing

### Requirements
- [bats-core](https://github.com/bats-core/bats-core) 1.1.0
- [jq](https://stedolan.github.io/jq/) 1.5

### Integration test
#### Terraform integration tests
The integration tests for this module are built with bats, basically the test checks the following:
- Perform `terraform init` command
- Perform `terraform get` command
- Perform `terraform plan` command and check that it'll create 6 resources, modify 0 resources and delete 0 resources
- Perform `terraform apply -auto-approve` command and check that it has created the 6 resources, modified 0 resources and deleted 0 resources
- Perform several `gcloud` commands and check the infrastructure is in the desired state
- Perform `terraform destroy -force` command and check that it has destroyed the 6 resources

You can use the following command to run the integration test in the folder */test/integration/gcloud-test*

  `. launch.sh`

Be sure to fill out the 'TF_VAR_project_id' and 'TF_VAR_credentials_path' environment variables in the launch.sh file