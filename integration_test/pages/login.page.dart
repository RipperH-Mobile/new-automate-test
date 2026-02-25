import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utils/common.util.dart';
import '../utils/mongodb/find_db.util.dart';

class LoginPage {
  final dynamic $;
  final FindDbUtil findDbUtil;

  LoginPage(this.$, this.findDbUtil);
  Future<void> proceedLogin({
    required bool isPhoneLogin,
    required String phoneWithoutCode,
    required String phoneWithCode,
    required String password,
    String? email,
  }) async {
    await CommonUtil.tapButton($, targetNameButton: 'Get Started');
    if (isPhoneLogin) {
      await CommonUtil.tapButton($, targetNameButton: 'Continue with phone number');
      await CommonUtil.fillTextInput($, targetNameInput: 'Phone No.', text: phoneWithoutCode);
    } else {
      if (email == null) throw Exception('Email login requires email');
      await CommonUtil.tapButton($, targetNameButton: 'Continue with email');
      await CommonUtil.fillTextInput($, targetNameInput: 'Email', text: email);
    }
    await CommonUtil.tapButton($, targetNameButton: 'Continue');
    // otp
    final isOtpDisplayed = await $(PinCodeTextField).exists;
    if (isOtpDisplayed) {
      await CommonUtil.getOtpTextFromDb($, findDbUtil, phoneWithCode);
      await $.pumpAndSettle();
      await $.waitUntilExists($('Later'));
      await CommonUtil.tapButton($, targetNameButton: 'Later');
    } else {
      await CommonUtil.fillTextInput($, targetNameInput: 'Password', text: password);
      await CommonUtil.tapButton($, targetNameButton: 'Continue');
    }
  }

  Future<void> proceedLogout($) async {
    await CommonUtil.tapButton($, targetNameButton: 'Accounts Center');
    await $.pumpAndSettle();
    await CommonUtil.tapIconCheckboxSelected($);
    await CommonUtil.tapButton($, targetNameButton: 'Sign out from this device');
    await CommonUtil.tapButton($, targetNameButton: 'Confirm');

    // //Navigation bar
    // final parentPopupMenuFinder = find.byType(Column);
    // final targetTextFinder = find.descendant(of: parentPopupMenuFinder, matching: find.byType(ListTile));
    // final targetProfileFinder = find.descendant(of: targetTextFinder, matching: find.byType(CircleAvatar));
    // await CommonUtil.tapButton($, targetNameButton: targetProfileFinder);
    // // My profile
    // await CommonUtil.tapButton($, targetNameButton: 'Log out');
    // await CommonUtil.tapButton($, targetNameButton: 'Confirm');
    // //await $.pumpAndSettle();
    // //await $.pump();
  }

  Future<void> proceedForgetPassword($, passwordFormPage, forgetPasswordByMap) async {
    await CommonUtil.tapButton($, targetNameButton: 'Get Started');
    if (forgetPasswordByMap.isLoginByPhone) {
      await CommonUtil.tapButton($, targetNameButton: 'Continue with phone number');
      await CommonUtil.fillTextInput($, targetNameInput: 'Phone No.', text: forgetPasswordByMap.phoneWithoutCode);
    } else {
      await CommonUtil.tapButton($, targetNameButton: 'Continue with email');
      await CommonUtil.fillTextInput($, targetNameInput: 'Email', text: forgetPasswordByMap.email);
    }
    await CommonUtil.tapButton($, targetNameButton: 'Continue');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Forgot password?');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Get OTP');
    await $.pump();
    final isOtpDisplayed = await $(PinCodeTextField).exists;
    if (isOtpDisplayed) {
      await CommonUtil.getOtpTextFromDb($, findDbUtil, forgetPasswordByMap.phoneWithCode);
      await $.pumpAndSettle();
      //await $.pump();
      //await $.pumpAndSettle(timeout: const Duration(seconds: 60));
      // await $.waitUntilExists($('Later'));
      // await CommonUtil.tapButton($, targetNameButton: 'Later');
    } else {
      await CommonUtil.fillTextInput($, targetNameInput: 'Password', text: forgetPasswordByMap.password);
      await CommonUtil.tapButton($, targetNameButton: 'Continue');
    }
    await $.pump();
    await passwordFormPage.proceedNewPassword(
      $,
      forgetPasswordByMap.newPassword,
      forgetPasswordByMap.confirmNewPassword,
    );
    await $("Password reset successful").waitUntilExists();
    await CommonUtil.tapButton($, targetNameButton: 'Done');
    await $.pump();
  }
}
