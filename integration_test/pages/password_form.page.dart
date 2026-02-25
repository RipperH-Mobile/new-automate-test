import 'package:flutter_test/flutter_test.dart';
import '../utils/common.util.dart';

class PasswordFormPage {
  Future<void> proceedNewPassword(
    $,
    String newPassword,
    String confirmNewPassword,
  ) async {
    await CommonUtil.fillTextInput(
      $,
      targetNameInput: 'Password',
      text: newPassword,
    );
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Continue');
    await $.pump();
    await CommonUtil.fillTextInput(
      $,
      targetNameInput: 'Password',
      text: confirmNewPassword,
    );
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Continue');
  }

  Future<void> inputCurrentPassword($, String currentPassword) async {
    await CommonUtil.fillTextInput(
      $,
      targetNameInput: 'Password',
      text: currentPassword,
    );
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Continue');
  }
}
