# bastion-group

This module will generate a managed instance group of bastion host VMs compatible with [OS Login](https://cloud.google.com/compute/docs/oslogin/) and [IAP Tunneling](https://cloud.google.com/iap/) that can be used to access internal VMs.

This module will:

- Create a dedicated service account for the bastion host
- Create managed instance group of GCE instances to be the bastion host
- Create a firewall rule to allow TCP:22 SSH access from the IAP to the bastion
- Necessary IAM bindings to allow IAP and OS Logins from specified members

## Usage

Basic usage of this module is as follows:

```hcl
module "bastion_group" {
  source = "terraform-google-modules/bastion-host/google//modules/bastion-group"
  version = "1.0.1"

  target_size = 2
  project     = var.project
  region      = var.region
  zone        = var.zone
  network     = google_compute_network.net.self_link
  subnet      = google_compute_subnetwork.net.self_link
  members = [
    "group:devs@example.com",
    "user:me@example.com",
  ]
}
```

Once the bastion group is created, you can search for the newly created
instances with something similar to the following:

```
$ gcloud compute instance-groups list-instances bastion-mig --region us-west1
NAME          ZONE        STATUS
bastion-9qgq  us-west1-c  RUNNING
bastion-rtv4  us-west1-b  RUNNING
```


Functional example is included in the
[examples](../../examples/) directory.

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
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

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| fw\_name\_allow\_ssh\_from\_iap | Firewall rule name for allowing SSH from IAP | string | `"allow-ssh-from-iap-to-bastion-group"` | no |
| health\_check | Health check config for the mig. | object | `<map>` | no |
| host\_project | The network host project ID | string | `""` | no |
| image\_family | Source image family for the Bastion. | string | `"centos-7"` | no |
| image\_project | Project where the source image for the Bastion comes from | string | `"gce-uefi-images"` | no |
| labels | Key-value map of labels to assign to the bastion host | map | `<map>` | no |
| machine\_type | Instance type for the Bastion host | string | `"n1-standard-1"` | no |
| members | List of IAM resources to allow access to the bastion host | list(string) | `<list>` | no |
| name | Name prefix of bastion instances | string | `"bastion"` | no |
| network | Self link for the network on which the Bastion should live | string | n/a | yes |
| project | The project ID to deploy to | string | n/a | yes |
| random\_role\_id | Enables role random id generation. | bool | `"true"` | no |
| region | The primary region where the bastion host will live | string | `"us-central1"` | no |
| scopes | List of scopes to attach to the bastion host | list | `<list>` | no |
| service\_account\_name | Account ID for the service account | string | `"bastion-group"` | no |
| service\_account\_roles | List of IAM roles to assign to the service account. | list | `<list>` | no |
| service\_account\_roles\_supplemental | An additional list of roles to assign to the bastion if desired | list | `<list>` | no |
| shielded\_vm | Enable shielded VM on the bastion host (recommended) | bool | `"true"` | no |
| startup\_script | Render a startup script with a template. | string | `""` | no |
| subnet | Self link for the subnet on which the Bastion should live. Can be private when using IAP | string | n/a | yes |
| tags | Network tags, provided as a list | list(string) | `<list>` | no |
| target\_size | Number of instances to create | string | `"1"` | no |
| zone | The primary zone where the bastion host will live | string | `"us-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_group | Instance-group url of managed instance group |
| self\_link | Name of the bastion MIG |
| service\_account | The email for the service account created for the bastion host |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
