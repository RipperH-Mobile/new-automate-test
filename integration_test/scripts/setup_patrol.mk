# Run command
# make -f integration_test/scripts/setup_patrol.mk setup_patrol 

.PHONY: setup_patrol

setup_patrol:
	@echo "🚀 Starting Patrol Automation Setup..."
	
	@# ---------------------------------------------------------
	@# STEP 1: Install Dependencies
	@# ---------------------------------------------------------
	@echo "📦 Installing Dependencies..."
	
	@# 1.1: Add Main Dependencies
#	@fvm flutter pub add csv:^6.0.0 http:^1.5.0 mongo_dart:^0.9.4 html:^0.15.6 phone_numbers_parser:^9.0.15
	
	@# 1.2: Add Dev Dependencies (Patrol 4.1.0) is compatibility with patrol_cli 4.0.2
#	@# https://patrol.leancode.co/documentation/compatibility-table
#	@fvm flutter pub add --dev patrol:^4.1.0

	@# 1.3: Activate CLIs
	@echo "🔧 Activating CLIs..."
	@fvm dart pub global activate patrol_cli --version 4.0.2
	@fvm dart pub global activate flutterfire_cli

	@# ---------------------------------------------------------
	@# STEP 3: Run Dart Scripts
	@# ---------------------------------------------------------
	@echo "📝 Running Config Scripts..."
	@fvm dart run integration_test/scripts/setup_assets.dart
#	@fvm dart run integration_test/scripts/setup_android.dart
	
# 	@# ตรวจสอบว่ามี Ruby script อยู่จริงไหมก่อนรัน (Optional safety)
# 	@if [ -f "integration_test/scripts/setup_ios.rb" ]; then \
# 		ruby integration_test/scripts/setup_ios.rb; \
# 	else \
# 		echo "⚠️ setup_ios.rb not found, skipping."; \
# 	fi

	@# ---------------------------------------------------------
	@# STEP 4: Pub Get & iOS Setup
	@# ---------------------------------------------------------
	@echo "🔄 Running pub get..."
	@fvm flutter pub get

	@echo "🍎 Precaching iOS artifacts..."
	@fvm flutter precache --ios

	@if [ "$$(uname)" = "Darwin" ]; then \
		echo "🍎 Detected macOS, checking iOS setup..."; \
		if [ -d "ios" ]; then \
			echo "   - Updating iOS pods..."; \
			cd ios && rm -rf Pods Podfile.lock && pod install --repo-update; \
		else \
			echo "   - No 'ios' directory found. Skipping Pod install."; \
		fi \
	fi

	@echo "🎉 All Done! Setup Complete."