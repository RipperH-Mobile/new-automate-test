
# Parse command line arguments
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <token> [flavor] [platforms]"
    echo "  token:     Firebase CI token (required)"
    echo "  flavor:    Specific flavor to configure (optional, default: all flavors)"
    echo "             Available: dev, sit, uat, prd"
    echo "  platforms: Comma-separated platforms (optional, default: ios,android)"
    echo "             Available: ios, android, ios,android"
    echo ""
    echo "Examples:"
    echo "  $0 <token>                    # Configure all flavors for ios,android"
    echo "  $0 <token> dev                # Configure only dev flavor for ios,android"
    echo "  $0 <token> dev ios            # Configure dev flavor for ios only"
    echo "  $0 <token> '' ios             # Configure all flavors for ios only"
    exit 1
fi

token=$1
flavor_filter="${2:-}"
platforms="${3:-ios,android}"

.tools/firebase_config_default.bash

FLAVORS=("dev" "sit" "uat" "prd")
APP_IDS=("social.uchat.messenger.dev" "social.uchat.messenger.sit" "social.uchat.messenger.uat" "social.uchat")
FIREBASE_OPTION_FILES=("firebase_options_dev.dart" "firebase_options_sit.dart" "firebase_options_uat.dart" "firebase_options_prd.dart")
PROJECT_IDS=("uchat-dev-d3114" "uchat-sit-66b9a" "uchat-uat-e72e0" "uchat-c1902")
IOS_BUILD_CONFIGS=("Release-dev" "Release-sit" "Release-uat" "Release-prd")
IOS_OUT=("ios/Firebase/dev/GoogleService-Info.plist" "ios/Firebase/sit/GoogleService-Info.plist" "ios/Firebase/uat/GoogleService-Info.plist" "ios/Firebase/prd/GoogleService-Info.plist")
ANDROID_OUT=("android/app/src/dev/google-services.json" "android/app/src/sit/google-services.json" "android/app/src/uat/google-services.json" "android/app/src/prd/google-services.json")

# Validate platforms parameter
if [[ "$platforms" != "ios" && "$platforms" != "android" && "$platforms" != "ios,android" ]]; then
    echo "Error: Invalid platforms '$platforms'"
    echo "Available platforms: ios, android, ios,android"
    exit 1
fi

# Validate flavor if provided
if [ -n "$flavor_filter" ]; then
    flavor_found=false
    for f in "${FLAVORS[@]}"; do
        if [ "$f" = "$flavor_filter" ]; then
            flavor_found=true
            break
        fi
    done
    
    if [ "$flavor_found" = false ]; then
        echo "Error: Invalid flavor '$flavor_filter'"
        echo "Available flavors: ${FLAVORS[*]}"
        exit 1
    fi
fi

echo "========================================="
echo "Firebase Configuration"
echo "Platforms: $platforms"
if [ -n "$flavor_filter" ]; then
    echo "Flavor: $flavor_filter"
else
    echo "Flavor: all (${FLAVORS[*]})"
fi
echo "========================================="

# Determine which flavors to process
if [ -n "$flavor_filter" ]; then
    # Single flavor mode
    PROCESS_FLAVORS=("$flavor_filter")
else
    # All flavors mode
    PROCESS_FLAVORS=("${FLAVORS[@]}")
fi

echo "Processing ${#PROCESS_FLAVORS[@]} flavor(s)..."
echo ""

# Process each selected flavor
for flavor in "${PROCESS_FLAVORS[@]}"; do
    # Find the index of this flavor
    flavor_index=-1
    for i in "${!FLAVORS[@]}"; do
        if [ "${FLAVORS[$i]}" = "$flavor" ]; then
            flavor_index=$i
            break
        fi
    done
    
    if [ $flavor_index -eq -1 ]; then
        echo "Error: Flavor '$flavor' not found in configuration"
        continue
    fi
    
    app_id=${APP_IDS[$flavor_index]}
    firebase_option_file=${FIREBASE_OPTION_FILES[$flavor_index]}
    project_id=${PROJECT_IDS[$flavor_index]}
    build_config=${IOS_BUILD_CONFIGS[$flavor_index]}
    ios_out=${IOS_OUT[$flavor_index]}
    android_out=${ANDROID_OUT[$flavor_index]}

    echo "Setting up FlutterFire for flavor '$flavor' with project '$project_id'"
    echo "  Platforms: $platforms"
    echo "  iOS Bundle ID: $app_id"
    echo "  iOS Build Config: $build_config"
    echo "  Android Package: $app_id"
    echo ""

    # Build the command arguments
    cmd_args=""
    cmd_args="$cmd_args --platforms=\"$platforms\""
    cmd_args="$cmd_args --project=\"$project_id\""
    cmd_args="$cmd_args --ios-bundle-id=\"$app_id\""
    cmd_args="$cmd_args --ios-build-config=\"$build_config\""
    cmd_args="$cmd_args --android-package-name=\"$app_id\""
    
    # Only add ios-out and android-out if no specific flavor is provided
    cmd_args="$cmd_args --ios-out=\"$ios_out\""
    cmd_args="$cmd_args --android-out=\"$android_out\""
    echo "  iOS Output: $ios_out"
    echo "  Android Output: $android_out"

#    if [ -z "$flavor_filter" ]; then
#        cmd_args="$cmd_args --ios-out=\"$ios_out\""
#        cmd_args="$cmd_args --android-out=\"$android_out\""
#        echo "  iOS Output: $ios_out"
#        echo "  Android Output: $android_out"
#    else
#        echo "  Using default output paths for single flavor configuration"
#    fi
    
    cmd_args="$cmd_args --token=\"$token\""
    cmd_args="$cmd_args --out=\"lib/firebase/$firebase_option_file\""
    cmd_args="$cmd_args --yes"
    
    # Execute the command
    eval "flutterfire configure $cmd_args"
    
    echo "  ✅ Completed configuration for flavor '$flavor'"
    echo ""
done

echo "========================================="
echo "🎉 Firebase configuration completed!"
echo "Processed ${#PROCESS_FLAVORS[@]} flavor(s): ${PROCESS_FLAVORS[*]}"
echo "Platforms: $platforms"
echo "========================================="