import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../features/account/account_setting_test.dart' as account_setting;
import '../features/account/delete_account_test.dart' as delete_account;
import '../features/account/forget_password_test.dart' as forget_password;
import '../features/account/login_test.dart' as login;
import '../features/account/register_test.dart' as register;
import '../features/account/user_setting_edit_detail_test.dart' as user_setting_edit_detail;
import '../features/account/user_setting_hide_phone_test.dart' as user_setting_hide_phone;
import '../features/account/user_setting_pin_lock_test.dart' as user_setting_pin_lock;
import '../features/account/user_setting_qrcode_test.dart' as user_setting_qrcode;
import '../utils/mongodb/base/base_db.util.dart';

void main() {
  setUpAll(() async {
    debugPrint('🪀 MAIN setUpAll Called');
    if (!dotenv.isInitialized) {
      await dotenv.load(fileName: '.env');
    }
    try {
      await mongoUtil.connectDb();
    } catch (e, stackTrace) {
      debugPrint('---connectDb error ---$e\n$stackTrace');
      rethrow;
    }
  });

  group('Account setting test scenario', () => account_setting.runTests());
  group('Delete account test scenario', () => delete_account.runTests());
  group('Forget password test scenario', () => forget_password.runTests());
  group('Login test scenario', () => login.runTests());
  group('Register test scenario', () => register.runTests());
  group('User setting edit detail test scenario', () => user_setting_edit_detail.runTests());
  group('User setting hide phone test scenario', () => user_setting_hide_phone.runTests());
  group('User setting pin lock test scenario', () => user_setting_pin_lock.runTests());
  group('User setting qrcode test scenario', () => user_setting_qrcode.runTests());

  tearDownAll(() async {
    debugPrint('🛑 MAIN tearDownAll Called! Disconnecting from MongoDB (Last)...');
    await mongoUtil.disconnectDb();
  });
}
