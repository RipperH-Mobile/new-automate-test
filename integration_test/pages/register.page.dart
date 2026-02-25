import 'package:flutter/material.dart';
import 'package:patrol/patrol.dart';
import 'package:flutter_test/flutter_test.dart';
import '../utils/common.util.dart';
import '../utils/mongodb/find_db.util.dart';

class RegisterPage {
  Future<void> proceedRegister($, FindDbUtil findDbUtil, Map<String, dynamic> registerByMap) async {
    try {
      await CommonUtil.tapButton($, targetNameButton: 'Get Started');
      await CommonUtil.tapButton($, targetNameButton: 'Continue with phone number');
      await CommonUtil.fillTextInput($, targetNameInput: 'Phone No.', text: registerByMap['phoneWithoutCode']);
      await CommonUtil.tapButton($, targetNameButton: 'Continue');
      await $.pump();
      await CommonUtil.getOtpTextFromDb($, findDbUtil, registerByMap['phoneWithCode']);
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: 'Agree and continue');
      await $.pump();
      await CommonUtil.fillTextInput($, targetNameInput: 'Name', text: registerByMap['profileName']);
      await $.pump();
      //await $.pumpAndSettle();
      await CommonUtil.tapButton($, targetNameButton: 'Continue');
      await $.pump();
      await CommonUtil.fillTextInput($, targetNameInput: 'Password', text: registerByMap['password']);
      await $.pump();
      //await $.pumpAndSettle();
      await CommonUtil.tapButton($, targetNameButton: 'Continue');
      await $.pump();
      await CommonUtil.fillTextInput($, targetNameInput: 'Password', text: registerByMap['confirmPassword']);
      //await $.pumpAndSettle();
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: 'Confirm this password');
      await $.pump();
      await CommonUtil.fillTextInput($, targetNameInput: 'UChat ID', text: registerByMap['uchatId']);
      await $.pump(const Duration(seconds: 2));
      await CommonUtil.tapButton($, targetNameButton: 'Continue');
      await $.pump();
      //await $.pumpAndSettle();
      await CommonUtil.tapButton($, targetNameButton: 'Later');

      // temp
      await $.pumpAndSettle();
      // await CommonUtil.tapButton($, targetNameButton: 'Got it');
      // await CommonUtil.tapButton($, targetNameButton: 'Back');
      // await $.pumpAndSettle();
      // await CommonUtil.tapButton($, targetNameButton: 'Back');
      // await $.pumpAndSettle();
      // await CommonUtil.tapButton($, targetNameButton: 'Back');
      // await $.pumpAndSettle();
      // await CommonUtil.tapButton($, targetNameButton: 'Back');
      // await $.pump();
      // await CommonUtil.tapButton($, targetNameButton: 'Confirm');
      // await $.pumpAndSettle();
      //

      // final actualNavigatePageFinder = $(AppBar).$(find.text(registerByMap['expectedNavigatePage']));
      // expect(actualNavigatePageFinder, findsOneWidget);
    } on PatrolFinderException catch (e) {
      debugPrint('Could not find widget error: $e');
    }
  }
}
