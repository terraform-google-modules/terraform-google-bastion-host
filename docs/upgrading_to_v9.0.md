# Upgrading to terraform-google-bastion-host v9.x

The v9.0 release of Google Bastion Host is a backwards incompatible release. 
Below a list of the breaking changes and the migration instructions.

## ⚠ BREAKING CHANGES

* The `region` variable now defaults to `us-central1` rather than `null` for instance templates.
* A minimum of Terraform v1.3 is now required.
