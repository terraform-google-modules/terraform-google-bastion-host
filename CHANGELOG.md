# Changelog

All notable changes to this project will be documented in this file.

The format is based on
[Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [6.0.0](https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v5.3.0...v6.0.0) (2023-10-30)


### ⚠ BREAKING CHANGES

* **deps:** Update Terraform terraform-google-modules/vm/google to v10 ([#153](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/153))

### Bug Fixes

* **deps:** Update Terraform terraform-google-modules/vm/google to v10 ([#153](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/153)) ([b2333ee](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/b2333ee6e1e0551b022257bbe019767bb5088a3f))
* upgraded versions.tf to include minor bumps from tpg v5 ([#157](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/157)) ([4456230](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/4456230664f86b80a2db2f98eef720abc793fd80))

## [5.3.0](https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v5.2.0...v5.3.0) (2023-04-06)


### Features

* add disk labels to bastion vm ([#128](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/128)) ([b1edf32](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/b1edf3268f458cbe1c02da8b0ea75a9db9381b59))

## [5.2.0](https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v5.1.1...v5.2.0) (2023-01-25)


### Features

* adds `region` setting used to configure the instance template ([#131](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/131)) ([00a863c](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/00a863ce0f37d69e6a9ac256aa358114a3a38bec))

## [5.1.1](https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v5.1.0...v5.1.1) (2023-01-20)


### Bug Fixes

* fixes lint issues and generates metadata ([#126](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/126)) ([b6267e6](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/b6267e6b69d0fe2ecdb53905912cd8619fb2e04d))

## [5.1.0](https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v5.0.1...v5.1.0) (2022-10-29)


### Features

* apply labels to bastion instance ([#114](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/114)) ([5dab8d1](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/5dab8d17b447fdecc0d164b2b48d1ba881b44a89))
* Optionally pass additional networks to the instance template ([#117](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/117)) ([5c601c9](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/5c601c9406a8d9066755f7fa5c4b84f934817bef))


### Bug Fixes

* **deps:** update module github.com/stretchr/testify to v1.8.1 ([#120](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/120)) ([6140420](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/6140420450097c6f5875379d2dd8ae936b2fd270))

## [5.0.1](https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v5.0.0...v5.0.1) (2022-09-07)


### Bug Fixes

* try() to fix index errors ([#108](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/108)) ([f566e8d](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/f566e8d9ebfd720f1832e5434ead017ea81849d1))

## [5.0.0](https://github.com/terraform-google-modules/terraform-google-bastion-host/compare/v4.1.0...v5.0.0) (2022-03-31)


### ⚠ BREAKING CHANGES

* renamed the ephemeral_ip variable to external_ip (#105)
* Update bastion image family to debian-11 (#102)

### Features

* Update bastion image family to debian-11 ([#102](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/102)) ([9f935eb](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/9f935eb1cc999a2c18eae148516ebd43e110cc79))


### Bug Fixes

* renamed the ephemeral_ip variable to external_ip ([#105](https://github.com/terraform-google-modules/terraform-google-bastion-host/issues/105)) ([1a63d4c](https://github.com/terraform-google-modules/terraform-google-bastion-host/commit/1a63d4ca0470ba423abb2aabe218f6c79f7c7fac))

## [4.1.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v4.0.0...v4.1.0) (2021-11-25)


### Features

* update TPG version constraints to allow 4.0 ([#98](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/98)) ([83f57db](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/83f57db571f66b457cee710276627b041a1374b5))

## [4.0.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v3.2.0...v4.0.0) (2021-09-10)

### ⚠ BREAKING CHANGES

* Update default image family and image project ([#89](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/89)) ([090c0ea](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/090c0ea0254cbd31434fc974f6219e2c3c3b8d86))

### Bug Fixes

* Update default image family and image project to fix [#88](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/88) ([#89](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/89)) ([090c0ea](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/090c0ea0254cbd31434fc974f6219e2c3c3b8d86))


### Miscellaneous Chores

* release 4.0.0 ([f5de94c](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/f5de94ce74c8aff7e88ec9cefd0effa956e02bc3))

## [3.2.0](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/compare/v3.1.0...v3.2.0) (2021-04-09)


### Features

* Add option for creating firewall rule. ([#82](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/82)) ([cdd37ff](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/cdd37ff566eebb3879336944bdf009e26d3fd2ff))
* add preemptible option. ([#83](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/issues/83)) ([7303a05](https://www.github.com/terraform-google-modules/terraform-google-bastion-host/commit/7303a054e5c0368cdd4e66764ed4f672dbbba832))

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
