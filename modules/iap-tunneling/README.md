# iap-tunneling

This module will create firewall rules and IAM bindings to allow TCP forwarding using
[Identity-Aware Proxy (IAP) Tunneling](https://cloud.google.com/iap/docs/using-tcp-forwarding).

This module will:

- Create firewall rules to allow connections from IAP's TCP forwarding IP addresses to the TCP port
of your resource's admin service.
- Create IAM bindings to allow IAP from specified members.

## Usage

Basic usage of this module is as follows:

```hcl
module "iap_tunneling" {
  source = "terraform-google-modules/bastion-host/google//modules/iap-tunneling"

  project                    = var.project
  network                    = var.network
  service_account            = var.service_account
  zone                       = var.zone
  name                       = var.name
  members = [
    "group:devs@example.com",
    "user:me@example.com",
  ]
}
```

Once the firewall rule is created, you can search for the newly created firewall rule with something
similar to the following:

```
$ gcloud compute firewall-rules list --project my-project --filter="name=allow-ssh-from-iap-to-tunnel"
NAME                          NETWORK  DIRECTION  PRIORITY  ALLOW   DENY  DISABLED
allow-ssh-from-iap-to-tunnel  default  INGRESS    1000      tcp:22        False
```

Once the IAM bindings for IAP-secured Tunnel User is created, you can verify them with something
similar to the following:

```
$ curl -H "Authorization: Bearer $(gcloud auth print-access-token)" -X POST \
https://iap.googleapis.com/v1beta1/projects/my-project/iap_tunnel/zones/us-central1-a/instances/my-instance:getIamPolicy
{
  "bindings": [
    {
      "role": "roles/iap.tunnelResourceAccessor",
      "members": [
        "user:me@example.com"
      ]
    }
  ]
}
```

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp]

### APIs

A project with the following APIs enabled must be used to host the resources of this module:

- Compute Engine API: `compute.googleapis.com`
- Cloud Identity-Aware Proxy API: `iap.googleapis.com`

The [Project Factory module][project-factory-module] can be used to provision a project with
the necessary APIs enabled.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| fw\_name\_allow\_ssh\_from\_iap | Firewall rule name for allowing SSH from IAP. | string | `"allow-ssh-from-iap-to-tunnel"` | no |
| host\_project | The network host project ID. | string | `""` | no |
| members | List of IAM resources to allow using the IAP tunnel. | list(string) | `<list>` | no |
| name | Name of the instance to allow SSH from IAP. If not specified, IAP tunnel user IAM binding will not be created. | string | `""` | no |
| network | Self link of the network to attach the firewall to. | string | n/a | yes |
| project | The project ID to deploy to. | string | n/a | yes |
| service\_account | Service account email associated with the instance to allow SSH from IAP. | string | n/a | yes |
| zone | Primary zone of the instance to allow SSH from IAP. | string | `"us-central1-a"` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html