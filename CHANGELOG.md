# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

