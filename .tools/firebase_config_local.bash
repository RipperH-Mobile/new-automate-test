
.tools/firebase_config_default.bash

FLAVORS=("dev" "sit" "uat" "prd")
APP_IDS=("social.uchat.messenger.dev" "social.uchat.messenger.sit" "social.uchat.messenger.uat" "social.uchat")
FIREBASE_OPTION_FILES=("firebase_options_dev.dart" "firebase_options_sit.dart" "firebase_options_uat.dart" "firebase_options_prd.dart")
PROJECT_IDS=("uchat-dev-d3114" "uchat-sit-66b9a" "uchat-uat-e72e0" "uchat-c1902")
IOS_BUILD_CONFIGS=("Debug-dev" "Debug-sit" "Debug-uat" "Debug-prd")
IOS_OUT=("ios/Firebase/dev/GoogleService-Info.plist" "ios/Firebase/sit/GoogleService-Info.plist" "ios/Firebase/uat/GoogleService-Info.plist" "ios/Firebase/prd/GoogleService-Info.plist")
ANDROID_OUT=("android/app/src/dev/google-services.json" "android/app/src/sit/google-services.json" "android/app/src/uat/google-services.json" "android/app/src/prd/google-services.json")

length=${#FLAVORS[@]}
for (( i=0; i<length; i++ )); do
  flavor=${FLAVORS[$i]}
  app_id=${APP_IDS[$i]}
  firebase_option_file=${FIREBASE_OPTION_FILES[$i]}
  project_id=${PROJECT_IDS[$i]}
  build_config=${IOS_BUILD_CONFIGS[$i]}
  ios_out=${IOS_OUT[$i]}
  android_out=${ANDROID_OUT[$i]}

  echo "Setting up FlutterFire for flavor '$flavor' with project '$project_id'"

  flutterfire configure \
    --platforms="ios,android" \
    --project="$project_id" \
    --ios-bundle-id="$app_id" \
    --ios-out="$ios_out" \
    --ios-build-config="$build_config" \
    --android-package-name="$app_id" \
    --android-out="$android_out" \
    --out="lib/firebase/$firebase_option_file" \
    -f -y
done