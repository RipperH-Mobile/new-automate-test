# Setup Project for fastlane

1. Install _fastlane_ using `brew install fastlane` or see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)
2. Install all plugins: `fastlane install_plugins`
3. Run `bundle install` to install all plugins from the `Gemfile`
4. If you don't have _Node.js_ installed, install it from [Node.js](https://nodejs.org/en/download/). But if you have it, make sure you have the latest version of _Node.js_ and _NPM_ installed.
5. Install package for DMG file creating with NPM: `npm install -g appdmg`, if you don't have it yet.
6. Restart your terminal to apply changes.

**Note**: to run _fastlane_ commands, you need to be in the `macos` directory.

# Commands

1. `fastlane delete_dmg`: Delete the DMG file from the installer directory
2. `fastlane build`: Build the macOS app
3. `fastlane pack_dmg`: Pack the macOS app to a DMG file
4. `fastlane build_dmg`: Build app and pack to DMG

# Note

- The config file location for DMG creator is `desktop_installers/dmg_creator/config.json`. You can change the config in this file to customize the DMG file.
- The output DMG file will be in the `desktop_installers/installer` directory, named as `UChat_Installer.dmg`.

# Troubleshooting

- If you have trouble using _fastlane_, check out the [Troubleshooting](https://docs.fastlane.tools/getting-started/ios/troubleshooting/) guide.
- If you have trouble with cocoaPods can not install pods in the project, try to run `flutter build macos --release` first for installing pods with flutter directly before run `fastlane build` or `fastlane dmg_pack`.