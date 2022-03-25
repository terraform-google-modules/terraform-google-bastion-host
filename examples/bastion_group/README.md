# Bastion Group Example

This example will set up a group of bastion hosts using a managed instance group (MIG).

## Deploy

Create a `terraform.tfvars` file with required variables similar to:

```
members = ["user:me@example.com"]
project = "my-project"
```

Run the apply

```
terraform apply
```

## Usage

Since gcloud's start-iap-tunnel currently does not support anything but instance names as targets
we have to do something akin to load balancing to get a random host of the instance group locally.
In this case we have two hosts we want to randomly choose from and ssh to.

```
gcloud auth login

INDEX=$((RANDOM % 2))
INSTANCE_URL=$(gcloud compute instance-groups list-instances bastion-mig --region us-west1 --format json | jq -r .[$INDEX].instance)
ZONE=$(echo $INSTANCE_URL | cut -d'/' -f9)
INSTANCE=$(echo $INSTANCE_URL | cut -d'/' -f11)
gcloud compute ssh $INSTANCE --zone $ZONE
```

You should now be logged in as a user that looks like `ext_me_example_com` with the prefix of `ext` indicating you have logged in with OS Login. You should also notice the following line in standard out that indicates you are tunnelling through IAP instead of the public internet:

```
External IP address was not found; defaulting to using IAP tunneling.
```

You could also modify this such that users ssh to the same bastion each time. Although for more granular
control over each instance, such as labelling per person or team, you should probably use the standard
bastion-host module instead.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| members | List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email} | `list(string)` | `[]` | no |
| project\_id | Project ID where to set up the instance and IAP tunneling | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
