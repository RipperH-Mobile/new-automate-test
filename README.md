# UChat Flutter

UChat Flutter project.

## Getting Started

Install `fvm` globally
```bash 
brew install fvm
```

## How to setup Firebase


1. First install `firebase-cli`.
```bash
brew install firebase-cli
````

2. Login to Firebase
```bash
firebase login
```

3. Integrate with Flutter by https://pub.dev/packages/flutterfire_cli. Install `FlutterFire CLI` globally
```bash
fvm flutter pub global activate flutterfire_cli
```

4. Run configure by env.


### For dev
```bash
flutterfire configure --platforms="ios,android" --project="uchat-dev-d3114" --ios-bundle-id="social.uchat.messenger.dev" --android-package-name="social.uchat.messenger.dev" --yes
```

### For sit
```bash
flutterfire configure --platforms="ios,android" --project="uchat-dev-d3114" --ios-bundle-id="social.uchat.messenger.sit" --android-package-name="social.uchat.messenger.sit" --yes
```

### For uat
```bash
flutterfire configure --platforms="ios,android" --project="uchat-dev-d3114" --ios-bundle-id="social.uchat.messenger.uat" --android-package-name="social.uchat.messenger.uat" --yes
```

## How to setup launcher icon

```bash
fvm dart run flutter_launcher_icons
```