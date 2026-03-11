#!/bin/bash

# --- 1. Argument Parsing & Validation ---
platform=$1
TEST_TARGET_FILE=$4
testscriptpath=$7

if [ "$platform" == "ios" ]; then
  ios_version=$2
  env=$3
  IOS_BUNDLE_ID=$6
  echo "'$platform'.'$ios_version'.'$env'.'$TEST_TARGET_FILE'.'$IOS_BUNDLE_ID'"

  if [ -z "$platform" ] || [ -z "$ios_version" ] || [ -z "$env" ] ; then
    echo "Usage (iOS): ./run_tests.sh ios <ios_version> <environment>"
    echo "Example: ./run_test_single.sh ios 15.5 sit"
    exit 1
  fi
  
elif [ "$platform" == "android" ]; then
  env=$3
  ANDROID_PACKAGE_NAME=$5
  echo "'$platform'.'$ios_version'.'$env'.'$TEST_TARGET_FILE'.'$ANDROID_PACKAGE_NAME'.'$IOS_BUNDLE_ID'"
  
  if [ -z "$platform" ] || [ -z "$env" ] ; then
    echo "Usage (Android): ./run_tests.sh android <environment>"
    echo "Example: ./run_tests_single.sh android sit"
    exit 1
  fi

else
  echo "Error: Invalid platform '$platform'. Use 'android' or 'ios'."
  exit 1
fi

LOCAL_RESULT_DIR="integration_test/test_results"
# 1. แปลง path เป็นชื่อไฟล์
sanitized_script_name=${testscriptpath//\//_}
# 2. ตัด .dart ออก
sanitized_no_ext=${sanitized_script_name%.dart}
# 3. สร้างชื่อไฟล์ผลลัพธ์
DYNAMIC_RESULT_FILENAME="${sanitized_no_ext}.csv"
# 4. สร้างชื่อไฟล์ Local
LOCAL_FILE_PATH="${LOCAL_RESULT_DIR}/${sanitized_no_ext}_${platform}_${env}.csv" 

echo "--- Running tests for: $platform ($([ "$platform" == "ios" ] && echo "v$ios_version" || echo "Android")) / $env ---"
echo "--- Test Script: $TEST_TARGET_FILE ---"
echo "--- Dynamic Result File: $DYNAMIC_RESULT_FILENAME ---"
echo "--- Local Results will be saved to: $LOCAL_FILE_PATH ---"

# --- 4. Test Execution ---
if [ "$platform" == "android" ]; then
    adb shell "run-as $ANDROID_PACKAGE_NAME mkdir -p app_flutter/temp_automate_result"
    echo "2. Running Patrol (Android) for $ANDROID_PACKAGE_NAME..."
    patrol test --flavor $env -t $TEST_TARGET_FILE --dart-define=RESULT_FILENAME=$DYNAMIC_RESULT_FILENAME --no-uninstall --show-flutter-logs
    
    echo "3. Pulling Android results..."
    DEVICE_INTERNAL_PATH="app_flutter/$DYNAMIC_RESULT_FILENAME"
    echo "adb shell "run-as $ANDROID_PACKAGE_NAME cat $DEVICE_INTERNAL_PATH" > "$LOCAL_FILE_PATH""
    if adb shell "run-as $ANDROID_PACKAGE_NAME cat $DEVICE_INTERNAL_PATH" > "$LOCAL_FILE_PATH"; then
      echo "✅ Successfully pulled results to $LOCAL_FILE_PATH"
      adb shell "run-as $ANDROID_PACKAGE_NAME rm $DEVICE_INTERNAL_PATH"
    else
      echo "⚠️ Warning: Could not pull Android results."
      rm -f "$LOCAL_FILE_PATH"
    fi

elif [ "$platform" == "ios" ]; then
    echo "2. Running Patrol (iOS $ios_version) for Scheme: $env / Bundle ID: $IOS_BUNDLE_ID..."
    fvm patrol test --flavor $env -t $TEST_TARGET_FILE --dart-define=RESULT_FILENAME=$DYNAMIC_RESULT_FILENAME --ios=$ios_version --no-uninstall --show-flutter-logs --verbose
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
    
    SIMULATOR_FILE_PATH="$APP_DATA_PATH/Documents/$DYNAMIC_RESULT_FILENAME"
    if [ -f "$SIMULATOR_FILE_PATH" ]; then
      cp "$SIMULATOR_FILE_PATH" "$LOCAL_FILE_PATH"
      echo "✅ Successfully copied results to $LOCAL_FILE_PATH"
      rm "$SIMULATOR_FILE_PATH"
    else
      echo "⚠️ Warning: Could not find results file at $SIMULATOR_FILE_PATH"
    fi

fi

echo "Test run complete."