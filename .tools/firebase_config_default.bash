
# TODO: Move firebase config to use production project
FLAVORS=("dev" "sit" "uat" "prd")

length=${#FLAVORS[@]}
for (( i=0; i<length; i++ )); do
  flavor=${FLAVORS[$i]}

  echo "Copy default file for flavor '$flavor'"

  cp ./lib/firebase/firebase_options_default.dart ./lib/firebase/firebase_options_"$flavor".dart
done