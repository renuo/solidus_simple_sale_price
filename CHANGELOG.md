
# Changelog

## [Unreleased]

### Added
- Compatibility fixes for Solidus 3.x.
- Moved decorators and testing factories for better organization.
- Activated decorators and added simplecov for test coverage.

### Changed
- Re-initialized the gem with `solidus_dev_support`.
- Linting and refactoring of decorators.

## [v0.0.3]
### Added
- Fixed issue when there's no price for the current currency (#4).
- Fixed nil comparison issue in `price_spec.rb`.

## [v0.0.2] 
### Added
- Added a nil check to prevent exceptions.
- Removed deprecated methods and improved tests to avoid N+1 queries.
- Added CI badge for continuous integration.

## [v0.0.1] 
### Added
- Initial release with sale price functionality for `Spree::Price`.
- Integrated helpers for currency-specific prices.
- Added support for test coverage with 100% mandatory coverage.
