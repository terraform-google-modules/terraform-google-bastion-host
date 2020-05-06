# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
...
## [2.4.0] - 2020-05-06
- Service Account variable override [#38]

## [2.3.0] - 2020-04-29
- Added image variable [#37]

## [2.2.0] - 2020-04-03

- Add name_prefix variable for instance template [#35]
- Bump Google provider version to 3.15
- Remove google-beta provider since it's no longer needed


## [2.1.1] - 2020-03-11
- Added type annotations to variables [#34]

## [2.1.0] - 2020-01-22
- Bumped Google provider to 3.4
- Pulled IAP Tunnelling into separate module [#29]

## [2.0.0] - 2020-01-10
- Added submodule and example for `bastion-group` [#27]

## [1.0.1] - 2020-01-03

- Fixed deprecation warnings due to quotes
- Added more integration tests

## [1.0.0] - 2019-11-22

### Fixed
- **Breaking**: Fixed issue with recreating custom roles by appending a random ID. Existing users can set `random_role_id` to `false` to avoid recreating the custom role. [#16]

## [0.2.0] - 2019-11-11

### Added
- Add support for img family, img project, shielded_vm. [#10]
- Added support for setting Shared VPC firewall rules. [#6](https://github.com/terraform-google-modules/terraform-google-bastion-host/pull/6)

### Fixed
- Fixed issue with using `scopes` variable. [#7](https://github.com/terraform-google-modules/terraform-google-bastion-host/pull/7)

## [0.1.0] - 2019-08-02

- Initial release

[Unreleased]: https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v0.2.0...v1.0.0
[0.2.0]: https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/terraform-google-modules/terraform-google-bastion-host/releases/tag/v0.1.0

[#16]: https://github.com/terraform-google-modules/terraform-google-bastion-host/pull/16
[#10]: https://github.com/terraform-google-modules/terraform-google-bastion-host/pull/10
