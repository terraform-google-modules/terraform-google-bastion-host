# terraform-google-bastion-host

This module will generate a bastion host vm compatible with [OS Login](https://cloud.google.com/compute/docs/oslogin/) and [IAP Tunneling](https://cloud.google.com/iap/) that can be used to access internal VMs.

This module will:

- Create a dedicated service account for the bastion host
- Create a GCE instance to be the bastion host
- Create a firewall rule to allow TCP:22 SSH access from the IAP to the bastion
- Necessary IAM bindings to allow IAP and OS Logins from specified members

## Usage

Basic usage of this module is as follows:

```hcl
module "iap_bastion" {
  source = "terraform-google-modules/bastion-host/google"

  project = var.project
  zone = var.zone
  network = google_compute_network.net.self_link
  subnet = google_compute_subnetwork.net.self_link
  members = [
    "group:devs@example.com",
    "user:me@example.com",
  ]
}
```

Functional example is included in the
[examples](./examples/) directory.

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] >= v0.12
- [Terraform Provider for GCP][terraform-provider-gcp]

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Storage JSON API: `storage-api.googleapis.com`
- Compute Engine API: `compute.googleapis.com`
- Cloud Identity-Aware Proxy API: `iap.googleapis.com`
- OS Login API: `oslogin.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

### Permissions

This module only sets up permissions for the bastion service account, not the users who need access. To allow access, grant one of the following instance access roles.

* `roles/compute.osLogin` Does not grant administrator permissions
* `roles/compute.osAdminLogin` Grants administrator permissions.

If the user does not share the same domain as the org the bastion is in, you will also need to grant that user `roles/compute.osLoginExternalUser`. This is to prevent external SSH access from being granted at the project level. See the [OS Login documentation](https://cloud.google.com/compute/docs/instances/managing-instance-access#configure_users) for more information.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional\_ports | A list of additional ports/ranges to open access to on the instances from IAP. | list(string) | `<list>` | no |
| create\_instance\_from\_template | Whether to create and instance from the template or not. If false, no instance is created, but the instance template is created and usable by a MIG | bool | `"true"` | no |
| disk\_size\_gb | Boot disk size in GB | string | `"100"` | no |
| disk\_type | Boot disk type, can be either pd-ssd, local-ssd, or pd-standard | string | `"pd-standard"` | no |
| fw\_name\_allow\_ssh\_from\_iap | Firewall rule name for allowing SSH from IAP | string | `"allow-ssh-from-iap-to-tunnel"` | no |
| host\_project | The network host project ID | string | `""` | no |
| image | Source image for the Bastion. If image is not specified, image_family will be used (which is the default). | string | `""` | no |
| image\_family | Source image family for the Bastion. | string | `"centos-7"` | no |
| image\_project | Project where the source image for the Bastion comes from | string | `"gce-uefi-images"` | no |
| labels | Key-value map of labels to assign to the bastion host | map | `<map>` | no |
| machine\_type | Instance type for the Bastion host | string | `"n1-standard-1"` | no |
| members | List of IAM resources to allow access to the bastion host | list(string) | `<list>` | no |
| metadata | Key-value map of additional metadata to assign to the instances | map(string) | `<map>` | no |
| name | Name of the Bastion instance | string | `"bastion-vm"` | no |
| name\_prefix | Name prefix for instance template | string | `"bastion-instance-template"` | no |
| network | Self link for the network on which the Bastion should live | string | n/a | yes |
| project | The project ID to deploy to | string | n/a | yes |
| random\_role\_id | Enables role random id generation. | bool | `"true"` | no |
| scopes | List of scopes to attach to the bastion host | list(string) | `<list>` | no |
| service\_account\_email | If set, the service account and its permissions will not be created. The service account being passed in should have at least the roles listed in the `service_account_roles` variable so that logging and OS Login work as expected. | string | `""` | no |
| service\_account\_name | Account ID for the service account | string | `"bastion"` | no |
| service\_account\_roles | List of IAM roles to assign to the service account. | list(string) | `<list>` | no |
| service\_account\_roles\_supplemental | An additional list of roles to assign to the bastion if desired | list(string) | `<list>` | no |
| shielded\_vm | Enable shielded VM on the bastion host (recommended) | bool | `"true"` | no |
| startup\_script | Render a startup script with a template. | string | `""` | no |
| subnet | Self link for the subnet on which the Bastion should live. Can be private when using IAP | string | n/a | yes |
| tags | Network tags, provided as a list | list(string) | `<list>` | no |
| zone | The primary zone where the bastion host will live | string | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| hostname | Host name of the bastion |
| instance\_template | Self link of the bastion instance template for use with a MIG |
| ip\_address | Internal IP address of the bastion host |
| self\_link | Self link of the bastion host |
| service\_account | The email for the service account created for the bastion host |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
