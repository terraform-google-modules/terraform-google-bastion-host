# Simple Example

This example will not set up the target hosts like the [Two Service Example](../two_service_example) but it will set up a basic network, subnet and bastion host for you to log into using IAP and OS Login. You'll notice that we create a firewall rule that allows the bastion to talk to the rest of the network on port 22 using the output of the bastion service account email for simplicity. This can and should be scoped down to allow access to specific hosts.

## Deploy

Create a `terraform.tfvars` file with required variables similar to:

```
members = ["user:me@example.com"]
project = "my-project"
```

Run the apply

```
terraform apply -var-file terraform.tfvars
```

## Usage

```
gcloud auth login
gcloud compute ssh bastion-vm
```

You should now be logged in as a user that looks like `ext_me_example_com` with the prefix of `ext` indicating you have logged in with OS Login. You should also notice the following line in standard out that indicates you are tunnelling through IAP instead of the public internet:

```
External IP address was not found; defaulting to using IAP tunneling.
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| members | List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email} | `list` | `[]` | no |
| project | Project ID where the bastion will run | `string` | n/a | yes |
| region | Region where the bastion will run | `string` | `"us-west1"` | no |
| zone | Zone where they bastion will run | `string` | `"us-west1-a"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
