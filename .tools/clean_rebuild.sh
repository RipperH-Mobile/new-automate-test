#!/bin/bash

echo "🧹 Starting complete clean and rebuild process..."

# Step 1: Clean Android gradle
echo "📱 Cleaning Android gradle..."
cd android
./gradlew clean
cd ..

# Step 2: Flutter clean
echo "🎯 Running flutter clean..."
fvm flutter clean

# Step 3: Get dependencies
echo "📦 Getting Flutter dependencies..."
fvm flutter pub get

cd ios
pod repo update
pod install

# Step 4: Delete build folders
echo "🗑️  Deleting build folders..."
rm -rf android/.gradle
rm -rf android/app/build
rm -rf build
