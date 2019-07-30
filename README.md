# terraform-google-bastion-host

This module was generated from [terraform-google-module-template](https://github.com/terraform-google-modules/terraform-google-module-template/).

This module will generate a bastion host vm compatible with os login and IAP tunneling that can be used to access internal VMs.

The resources/services/activations/deletions that this module will create/trigger are:

- Creates a dedicated service account for the bastion host VM
- Creates a GCE instance of n1-standard to be the bastion
- Firewall to allow TCP:22 ssh access from the IAP to the bastion
- Firewall to allow TCP:22 ssh acccess from the bastion to other instances on the network
- IAM binding to allow members to utilize the IAP Tunnel
- IAM binding granting os login to members through the bastion host
- IAM binding granting the usage of the dedicated bastion host service account
- Creates a custom role that has limited privileges to enable OS Login on an instance level
- IAM binding to the custom role

## Usage

Basic usage of this module is as follows:

```hcl
module "iap_bastion" {
  source = "terraform-google-modules/terraform-google-bastion-host/"
  project_id  = "<PROJECT ID>"
  subnet = "<VPC_SUBNET>"
  network = "<VPC_NETWORK>"
  zone = "<ZONE>"
  members = "<MEMBERS>"
}
```

Functional example is included in the
[examples](./examples/) directory.

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.11
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.0

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`
- Compute Engine API: `compute.googleapis.com`
- Cloud Identity-Aware Proxy API: `iap.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
