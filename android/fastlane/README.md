fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android production

```sh
[bundle exec] fastlane android production
```



### android beta

```sh
[bundle exec] fastlane android beta
```



### android test

```sh
[bundle exec] fastlane android test
```

Runs all the tests

### android build

```sh
[bundle exec] fastlane android build
```



### android release

```sh
[bundle exec] fastlane android release
```

Deploy a new version to the Google Play

### android update_metadata

```sh
[bundle exec] fastlane android update_metadata
```



### android beta_bkp

```sh
[bundle exec] fastlane android beta_bkp
```

Submit a new Beta Build to Crashlytics Beta

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
