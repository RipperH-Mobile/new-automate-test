fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Mac

### mac delete_dmg

```sh
[bundle exec] fastlane mac delete_dmg
```

Delete the DMG file from the installer directory

### mac build

```sh
[bundle exec] fastlane mac build
```

Build the macOS app

### mac pack_dmg

```sh
[bundle exec] fastlane mac pack_dmg
```

Pack the macOS app to a DMG file

### mac build_dmg

```sh
[bundle exec] fastlane mac build_dmg
```

Build app and pack to DMG

### mac beta

```sh
[bundle exec] fastlane mac beta
```

Push a new beta build to TestFlight

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
