#!/bin/bash

# --- 1. Argument Parsing & Validation ---
platform=$1
TEST_TARGET_FILE=$4
REPORT_DIR="integration_test/test_results"

if [ ! -d "$REPORT_DIR" ]; then
    echo "📂 Creating directory: $REPORT_DIR"
    mkdir -p "$REPORT_DIR"
fi

if [ "$platform" == "ios" ]; then
  ios_version=$2
  env=$3
  IOS_BUNDLE_ID=$6
  echo "'$platform'.'$ios_version'.'$env'.'$TEST_TARGET_FILE'.'$IOS_BUNDLE_ID'"

  if [ -z "$platform" ] || [ -z "$ios_version" ] || [ -z "$env" ] ; then
    echo "Usage (iOS): ./run_tests.sh ios <ios_version> <environment>"
    echo "Example: ./run_test_batch.sh ios 15.5 sit"
    exit 1
  fi
  
elif [ "$platform" == "android" ]; then
  env=$3
  ANDROID_PACKAGE_NAME=$5
  echo "'$platform'.'$ios_version'.'$env'.'$TEST_TARGET_FILE'.'$ANDROID_PACKAGE_NAME'.'$IOS_BUNDLE_ID'"
  
  if [ -z "$platform" ] || [ -z "$env" ] ; then
    echo "Usage (Android): ./run_tests.sh android <environment>"
    echo "Example: ./run_tests_batch.sh android sit"
    exit 1
  fi

else
  echo "Error: Invalid platform '$platform'. Use 'android' or 'ios'."
  exit 1
fi

# --- 4. Test Execution ---
if [ "$platform" == "android" ]; then
    REMOTE_PATH="/storage/emulated/0/Download/temp_automate_result/"
    DEVICE_ID=$(adb devices | grep "emulator-" | head -n 1 | awk '{print $1}')

    # เช็กว่าเจอ Emulator ไหม
    if [ -z "$DEVICE_ID" ]; then
        echo "❌ Error: ไม่พบ Emulator ที่กำลังทำงานอยู่"
        exit 1
    fi
    echo "✅ Auto-detected Emulator ID: $DEVICE_ID"
    echo "2. Running Patrol (Android) for $ANDROID_PACKAGE_NAME..."
    fvm patrol test --flavor $env -t $TEST_TARGET_FILE --dart-define=ENV=$env --dart-define=DEVICE=$platform --no-uninstall --show-flutter-logs

    echo "3. Pulling Android results..."
    if adb -s "$DEVICE_ID" pull "$REMOTE_PATH". "$REPORT_DIR"; then
      echo "✅ Successfully pulled results"
      adb -s "$DEVICE_ID" shell rm -rf "$REMOTE_PATH"
    else
      echo "⚠️ Warning: Could not pull Android results."
    fi

elif [ "$platform" == "ios" ]; then
    echo "2. Running Patrol (iOS $ios_version) for Scheme: $IOS_SCHEME_NAME / Bundle ID: $IOS_BUNDLE_ID..."
    fvm patrol test --flavor $env -t $TEST_TARGET_FILE --dart-define=ENV=$env --dart-define=DEVICE=$platform --ios=$ios_version --no-uninstall --show-flutter-logs

    echo "3. Pulling iOS Simulator results..."
    echo "   (Note: This method only works on Simulators)"
    
    SIM_UDID=$(xcrun simctl list devices | grep Booted | awk -F'[()]' '{print $2}' | head -n 1)
    
    if [ -z "$SIM_UDID" ]; then
      echo "⚠️ Error: No booted iOS Simulator found."
      exit 1
    fi
    
    echo "   Found booted simulator: $SIM_UDID"
    APP_DATA_PATH=$(xcrun simctl get_app_container "$SIM_UDID" "$IOS_BUNDLE_ID" data)
    if [ -z "$APP_DATA_PATH" ]; then
       echo "⚠️ Error: Could not find app data container for $IOS_BUNDLE_ID."
       echo "   Please verify BASE_IOS_BUNDLE_ID and that the app is installed."
       exit 1
    fi
    
    SOURCE_DIR_NAME="temp_automate_result"
    FULL_SOURCE_PATH="$APP_DATA_PATH/Documents/$SOURCE_DIR_NAME"

    if [ -d "$FULL_SOURCE_PATH" ]; then
      echo "   Found results at: $FULL_SOURCE_PATH"
      cp -R "$FULL_SOURCE_PATH/"* "$REPORT_DIR/"
      if [ $? -eq 0 ]; then
          echo "✅ Successfully pulled iOS results from Simulator to $(pwd)/$SOURCE_DIR_NAME"
          # Delete source files
          rm -rf "$FULL_SOURCE_PATH"
          echo "🧹 Simulator source files have been cleaned up."
      else
          echo "⚠️ Copy failed! (Simulator files were NOT deleted for safety)."
          exit 1
      fi
    else
      echo "⚠️ Warning: Could not find results folder at $FULL_SOURCE_PATH"
      echo "   Please check if Flutter app writes to 'ApplicationDocumentsDirectory/$SOURCE_DIR_NAME'"
    fi

fi

echo "Test run complete."