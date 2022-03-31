# Upgrading to terraform-google-bastion-host v5.x

The v5.0 release of Google Bastion Host is a backwards incompatible release. 
Below a list of the breaking changes and the migration instructions.

## ⚠ BREAKING CHANGES

* Renamed the `ephemeral_ip` variable to `external_ip` as it is possible to specify not only an ephemeral IP but also a static external IP.

## Migration Instructions

The following diff shows the breaking changes introduced in version 5 compared to version 4.

```diff
module "iap_bastion" {
  source   = "terraform-google-modules/bastion-host/google"
- version  = "v4.1"
+ version  = "v5.0"

- ephemeral_ip = true
+ external_ip = true

}
```
