# IAP Tunneling Example

This example will create a testing VM and set up the firewall and IAM bindings to allow IAP connections to it for given members.

## Deploy

Create a `terraform.tfvars` file with required variables similar to:

```
members = ["user:me@example.com"]
project = "my-project"
instance = "instance-1"
zone     = "us-central1-a"
region   = "us-central1"
```

Run the apply

```
terraform apply
```

## Usage

You can ssh to the VM instance with something similar to the following:

```
gcloud auth login
gcloud compute ssh instance-1 --zone us-central1-a --project my-project
```

You should now be logged in as a user that looks like `ext_me_example_com` with the prefix of `ext` indicating you have logged in with OS Login.
You should also notice the following line in standard out that indicates you are tunnelling through IAP instead of the public internet:

```
External IP address was not found; defaulting to using IAP tunneling.
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance | Name of the example VM instance to create and allow SSH from IAP. | `any` | n/a | yes |
| members | List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email} | `list(string)` | n/a | yes |
| project | Project ID where to set up the instance and IAP tunneling | `any` | n/a | yes |
| region | Region to create the subnet and example VM. | `string` | `"us-west1"` | no |
| zone | Zone of the example VM instance to create and allow SSH from IAP. | `string` | `"us-west1-a"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
