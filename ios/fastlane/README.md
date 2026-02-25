fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios process_build_number

```sh
[bundle exec] fastlane ios process_build_number
```

Increment the build number

### ios process_version_number

```sh
[bundle exec] fastlane ios process_version_number
```

Increment the version number

### ios build_adhoc

```sh
[bundle exec] fastlane ios build_adhoc
```

Build ios adhoc app

### ios build

```sh
[bundle exec] fastlane ios build
```

Build ios app

### ios deploy_testflight

```sh
[bundle exec] fastlane ios deploy_testflight
```



### ios build_prd

```sh
[bundle exec] fastlane ios build_prd
```

Build prd

### ios prd

```sh
[bundle exec] fastlane ios prd
```

Push a new release build to TestFlight

### ios build_dev

```sh
[bundle exec] fastlane ios build_dev
```

Build dev

### ios dev

```sh
[bundle exec] fastlane ios dev
```

Push a new dev build to TestFlight

### ios build_uat

```sh
[bundle exec] fastlane ios build_uat
```

Build uat

### ios uat

```sh
[bundle exec] fastlane ios uat
```

Push a new uat build to TestFlight

### ios build_sit

```sh
[bundle exec] fastlane ios build_sit
```

Build sit

### ios sit

```sh
[bundle exec] fastlane ios sit
```

Push a new sit build to TestFlight

### ios register_ios_devices

```sh
[bundle exec] fastlane ios register_ios_devices
```



### ios upload_dsym

```sh
[bundle exec] fastlane ios upload_dsym
```

Upload dSYM to Firebase Crashlytics

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
