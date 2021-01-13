# Two Service Example

This example illustrates how to use the `bastion-host` module. It illustrate an example where there are two services being deployed in a single project. Service A is deployed to two VMS (priv-host-a-1 and priv-host-a-2) and Service B is deployed to a single VM (priv-host-b-1). The bastion host module is deployed that will allow User A to access VM's for Service A, and User B to access Service B through the shared bastion host. You'll notice that we create a firewall rule that allows the bastion to talk to the rest of the network on port 22 using the output of the bastion service account email for simplicity. This can and should be scoped down to allow access to specific hosts.


## Deploy

Create a `terraform.tfvars` file with required variables. Should look something like:

```
project = "my-project"
user_a = "user:me@example.com"
user_b = "user:someone@example.com"
network = "projects/my-project/global/networks/default"
subnet = "projects/rcanty-project-0529/regions/us-west1/subnetworks/default"
```

Run the apply

```
terraform apply -var-file terraform.tfvars
```

## Usage

After this module is deployed, you can test SSHing to the private hosts by following these steps:

Login as User A:

```
gcloud auth login
```

If you have existing google_compute_engine ssh keys, ( ~/.ssh/google_compute_engine.pub ) back them up, otherwise skip this step

```
cd ~/.ssh # change working directory to ssh directory
mv google_compute_engine.pub google_compute_engine_backup.pub # backup public key
mv google_compute_engine google_compute_engine_backup_backup # backup private key
```

Update your gcloud config

```
gcloud config set project <project-id>
gcloud config set compute/region us-west1
gcloud config set compute/zone us-west1-a
```

Generate new google compute engine keys and ssh over to bastion host

```
gcloud compute ssh bastion-vm
```

Exit out from bastion using `exit`. Then start SSH Agent and add your key to it:

```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/google_compute_engine
```

SSH to private VM through bastion host

```
gcloud compute ssh bastion-vm --ssh-flag="-A" --command "ssh priv-host-a-1" -- -t
```


You can also try SSHing to the other host, priv-host-a-2. This should work. Try sshing to the B host, (priv-host-b-2) should fail. Try using user B, get another user to follow above steps. If you have access to a test account, you can use that as well, but make sure to backup the ssh keys from the steps above.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| network | Self link for the VPC network | `string` | n/a | yes |
| project | The ID of the project in which to provision resources. | `string` | n/a | yes |
| subnet | Self link for the Subnet within var.network | `string` | n/a | yes |
| user\_a | User in the IAM policy format of user:{email} | `any` | n/a | yes |
| user\_b | User in the IAM policy format of user:{email} | `any` | n/a | yes |
| zone | n/a | `string` | `"us-west1-a"` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
