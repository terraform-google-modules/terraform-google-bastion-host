# Two Service Example

This example illustrates how to use the `iap-bastion` module. It illustrate an example where there are two services being deployed in a single project. Service A is deployed to two VMS (priv-host-a-1 and priv-host-a-2) and Service B is deployed to a single VM (priv-host-b-1). The bastion host module is deployed that will allow User A to access VM's for Service A, and User B to access Service B through the shared bastion host.

After this module is deployed, you can test ssh-ing to the private hosts by following these steps:

1. Login as User A:

- `gcloud auth login` login as user A

2. If you have existing google_compute_engine ssh keys, ( ~/.ssh/google_compute_engine.pub ) back them up, otherwise continue to step 3

- `cd ~/.ssh` change working directory to ssh directory
- `mv google_compute_engine.pub google_compute_engine_backup.pub` backup public key
- `mv google_compute_engine google_compute_engine_backup_backup` backup private key

3. Change project to sample project

- `gcloud config set project <project-id>` change to project id that you used

4. Generate new google compute engine keys and ssh over to bastion host

- `gcloud compute ssh bastion-vm --zone=<zone you used>` zone defaults to us-central1-a

5. Exit out from bastion

- `exit` should return to local terminal

6. Start SSH Agent

- `eval "$(ssh-agent -s)"`

7. Add SSH key to the ssh-agent

- `ssh-add ~/.ssh/google_compute_engine`

8. SSH to private VM through bastion host

- `gcloud compute ssh bastion-vm --zone=us-central1-a --ssh-flag="-A" --command "ssh priv-host-a-1" -- -t`

9. Can also try sshing to the other host, priv-host-a-2. Should work. Try sshing to the B host, (priv-host-b-2) should fail. Try using user B, get another user to follow above steps. If you have access to a test account, you can use that as well, but make sure to backup the ssh keys from the steps above.
