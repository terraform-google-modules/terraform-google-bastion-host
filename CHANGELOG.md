# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.1.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v3.0.0...v3.1.0) (2021-03-09)


### Features

* Add ephemeral_ip to bastion host. ([#73](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/73)) ([c4dbeab](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/c4dbeab0ab89ef52565020821e6fd24a9c18078a))

## [3.1.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v3.0.0...v3.1.0) (2021-02-23)


### Features

* Add ephemeral_ip to bastion host. ([#73](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/73)) ([c4dbeab](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/c4dbeab0ab89ef52565020821e6fd24a9c18078a))

## [3.0.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v2.10.2...v3.0.0) (2021-01-13)


### ⚠ BREAKING CHANGES

* Bump instance template version to support terraform 0.14 (#70)

### Features

* Bump instance template version to support terraform 0.14 ([#70](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/70)) ([be00982](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/be0098210d789f6e2a11de347dd244380f151114))

### [2.10.2](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v2.10.1...v2.10.2) (2020-12-15)


### Bug Fixes

* Pass host_project variable into instance_template module ([#63](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/63)) ([1c88a0c](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/1c88a0ccd58a5221e2203b2c2a21953dbdef6579))
* pass labels into instance template ([#69](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/69)) ([c4ff7e7](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/c4ff7e72c36c506a4aa4011407653dcceb47bcc2))

### [2.10.1](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v2.10.0...v2.10.1) (2020-12-10)


### Bug Fixes

* Remove < 0.14 constraint [bot-pr] ([#64](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/64)) ([6690be3](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/6690be327c335522fb5db12b67ff90b5b1c8ad51))

## [2.10.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v2.9.0...v2.10.0) (2020-10-07)


### Features

* support additional metadata for instances ([#52](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/52)) ([46456a2](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/46456a29405f207b211481846d4d613f3e7430ac))

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
