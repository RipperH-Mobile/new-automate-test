#!/bin/bash

# --- 1. Argument Parsing & Validation ---
platform=$1

if [ "$platform" == "ios" ]; then
  # กรณี iOS: รับ 4 ค่า (platform, ios_version, env, path)
  ios_version=$2
  env=$3
  testscriptpath=$4
  
  if [ -z "$platform" ] || [ -z "$ios_version" ] || [ -z "$env" ] || [ -z "$testscriptpath" ]; then
    echo "Usage (iOS): ./run_tests.sh ios <ios_version> <environment> <testscriptpath>"
    echo "Example: ./run_tests.sh ios 15.5 sit features/account/login_test.dart"
    exit 1
  fi
  
elif [ "$platform" == "android" ]; then
  # กรณี Android: รับ 3 ค่า (platform, env, path)
  env=$2
  testscriptpath=$3
  
  if [ -z "$platform" ] || [ -z "$env" ] || [ -z "$testscriptpath" ]; then
    echo "Usage (Android): ./run_tests.sh android <environment> <testscriptpath>"
    echo "Example: ./run_tests.sh android sit features/account/login_test.dart"
    exit 1
  fi

else
  echo "Error: Invalid platform '$platform'. Use 'android' or 'ios'."
  exit 1
fi

test_dir=$(dirname "$testscriptpath")
# feature_folder=$(basename "$test_dir")

if [[ "$testscriptpath" == *"test_suites"* ]]; then
    filename=$(basename "$testscriptpath")
    temp_name="${filename#suite_feature_}"
    feature_folder="${temp_name%_test.dart}"
else
    feature_folder=$(basename "$test_dir")
fi
echo "Feature Folder: $feature_folder"

# --- 2. Configuration ---
BASE_ANDROID_PACKAGE="social.uchat.messenger"
BASE_IOS_BUNDLE_ID="social.uchat.messenger"
IOS_SCHEME_NAME=$env 
TEST_TARGET_FILE="integration_test/${testscriptpath}"
LOCAL_RESULT_DIR="integration_test/test_results"
mkdir -p $LOCAL_RESULT_DIR
ANDROID_PACKAGE_NAME="${BASE_ANDROID_PACKAGE}.${env}"
IOS_BUNDLE_ID="${BASE_IOS_BUNDLE_ID}.${env}"

# --- 3. Setup ---
echo "1. Preparing test assets for '$env' (Feature: $feature_folder)..."
dart run integration_test/utils/prepare_test_assets.util.dart setup $env $feature_folder

if [[ "$testscriptpath" == *"test_suites"* ]]; then
    chmod +x ./integration_test/scripts/run_test_batch.sh
    ./integration_test/scripts/run_test_batch.sh "$platform" "$ios_version" "$env" "$TEST_TARGET_FILE" "$ANDROID_PACKAGE_NAME" "$IOS_BUNDLE_ID"
else
    chmod +x ./integration_test/scripts/run_test_single.sh
    ./integration_test/scripts/run_test_single.sh "$platform" "$ios_version" "$env" "$TEST_TARGET_FILE" "$ANDROID_PACKAGE_NAME" "$IOS_BUNDLE_ID" "$testscriptpath"
fi

if [ "$platform" == "ios" ]; then
    if xcrun simctl uninstall booted $IOS_BUNDLE_ID 2>/dev/null; then 
       echo "✅ Successfully reset (uninstalled) app $IOS_BUNDLE_ID"
    else
       echo "ℹ️ App $IOS_BUNDLE_ID was not installed, ready for clean install."
    fi
elif [ "$platform" == "android" ]; then
    if adb shell pm clear $ANDROID_PACKAGE_NAME; then
      echo "✅ Successfully reset app $ANDROID_PACKAGE_NAME"
    else
      echo "⚠️ Warning: Could not reset app $ANDROID_PACKAGE_NAME"
    fi
fi

echo "4. Cleaning up test assets..."
dart run integration_test/utils/prepare_test_assets.util.dart teardown $env $feature_folder

#curl -X POST http://localhost:5678/webhook/patrol-done

echo "Test run complete."