# Simple Bastion Host

This example configures a single bastion host inside of a project.

The example's bastion host network defaults to the 'default' network, and allows ssh connections from all sources.

It will do the following:
- Create an instance
- Create a firewall rule
- Create a service account

Expected variables:
- `project_id`
- `credentials_file_path`