# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.2](https://github.com/township-agency/ex_teal_direct_upload/compare/v1.1.1...v1.1.2) (2024-04-26)


### Bug Fixes

* Upgrade Build system, fix bug ([#58](https://github.com/township-agency/ex_teal_direct_upload/issues/58)) ([534aea1](https://github.com/township-agency/ex_teal_direct_upload/commit/534aea10e648c4f92a0097425211a99230361b70))

## [1.1.1](https://github.com/township-agency/ex_teal_direct_upload/compare/v1.1.0...v1.1.1) (2024-01-24)


### Bug Fixes

* Form Fields have errors that should be passed to the default field wrapper ([#56](https://github.com/township-agency/ex_teal_direct_upload/issues/56)) ([e36bef4](https://github.com/township-agency/ex_teal_direct_upload/commit/e36bef42647a6107baa39115662639b9ffc4ece9))

## [1.1.0](https://github.com/township-agency/ex_teal_direct_upload/compare/v1.0.2...v1.1.0) (2023-10-09)


### Features

* Allow Direct Upload to provide upload functionality to Teal and other plugins ([#54](https://github.com/township-agency/ex_teal_direct_upload/issues/54)) ([1bf0c1a](https://github.com/township-agency/ex_teal_direct_upload/commit/1bf0c1a6fa9c5484d8bec1f2157f5b08d12e0095))

## [1.0.2](https://github.com/township-agency/ex_teal_direct_upload/compare/v1.0.1...v1.0.2) (2023-09-18)


### Bug Fixes

* Image Form field direct link and sizing ([#52](https://github.com/township-agency/ex_teal_direct_upload/issues/52)) ([2a48cf2](https://github.com/township-agency/ex_teal_direct_upload/commit/2a48cf2cfefdbe9d8bdada6f6cc684ccbf423918))

## [1.0.1](https://github.com/township-agency/ex_teal_direct_upload/compare/v1.0.0...v1.0.1) (2023-05-01)


### Bug Fixes

* prep for public teal release ([#30](https://github.com/township-agency/ex_teal_direct_upload/issues/30)) ([e8319af](https://github.com/township-agency/ex_teal_direct_upload/commit/e8319afe55ce6678e98cf07c4832ff9e333de973))

## [1.0.0](https://github.com/township-agency/ex_teal_direct_upload/compare/v0.8.0...v1.0.0) (2023-03-29)


### ⚠ BREAKING CHANGES

* refactor to be imgix optional ([#28](https://github.com/township-agency/ex_teal_direct_upload/issues/28))

### Features

* Array Field ([470c6c3](https://github.com/township-agency/ex_teal_direct_upload/commit/470c6c3ed41981c7d6f37df4fd221e6029381e85))
* refactor to be imgix optional ([#28](https://github.com/township-agency/ex_teal_direct_upload/issues/28)) ([c9e7ec7](https://github.com/township-agency/ex_teal_direct_upload/commit/c9e7ec78c995604f9c7e52f9c9de7ce2c211b0e3))

## [0.8.1] - 2022-05-13

### Changes
- Bump Erlang / AWS / Elixir dependencies

## [0.8.0] - 2021-10-04

### Changes
- Bump `ex_teal` to `>= 0.16`

## [0.7.0] - 2020-07-22

### Adds
- Imgix Array Field

## [0.6.0] - 2020-01-21

### Breaking Changes
- Bump `ex_teal` to 0.7.0

## [0.5.0] - 2019-12-03

### Breaking Changes

Plugin module renamed to `ExTealDirectUpload.Plugin`.  In
`lib/{your_web_app}/ex_teal/manifest.ex` change the name of the direct upload
plugin from `ExTealDirectUpload.new(%{})` to
`ExTealDirectUpload.Plugin.new(%{})` in the `plugins/0` function.

### Adds
- Direct Upload now supports different `acl` policies for objects stored on S3
- File Forms now include a remove button
- Direct Upload can now generate presigned urls for private S3 Objects.

## [0.4.0] - 2019-10-21

### Changed
- Updated `ex_teal` to `~> 0.4`
### Fixed
- Fixed compatibility with `ex_teal ~> 0.4`

## [0.3.] - 2019-07-18

### Changed

- Added JS Components
- Updated `ex_teal` to `0.3`

## [0.1.0] - 2018-11-28
### Initial Release
