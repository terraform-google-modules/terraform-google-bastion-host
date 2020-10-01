# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.9.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v2.8.0...v2.9.0) (2020-10-01)


### Features

* Support terraform 0.13 ([#55](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/55)) ([0739dfb](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/0739dfb7fe0e07ea1a8b409edbcf02efa873d2a5))

## [2.8.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v2.7.0...v2.8.0) (2020-09-22)


### Features

* Fix failing tests in master ([#53](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/53)) ([79f0249](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/79f02493f1c619113f757a6fcdecb9d54cd1ea8c))

## [2.7.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v2.6.0...v2.7.0) (2020-06-24)


### Features

* Added option to specify the fw rule name for ssh to health checks ([#45](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/45)) ([4ef9f78](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/4ef9f78297deeaf00c8d296be55e39220d5cb551))

## [2.6.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v2.5.0...v2.6.0) (2020-06-11)


### Features

* update instance template version (see: [#40](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/40)) ([6dc6299](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/6dc62991daa04918e335e096f5ee4ad3a42ceff2))

## [2.5.0] - 2020-05-11
- Disk size and type variable override [#39]

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
