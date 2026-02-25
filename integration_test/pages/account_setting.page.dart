import 'dart:io';

import 'package:patrol/patrol.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'password_form.page.dart';
import 'package:uchat/features/profile/presentation/views/screens/mobile/passcode/passcode_toggle_screen.dart';
import 'package:intl/intl.dart';
import '../utils/common.util.dart';
import '../utils/mongodb/find_db.util.dart';

class AccountSettingPage {
  Future<void> proceedAddEmail(
    $,
    FindDbUtil findDbUtil,
    PasswordFormPage passwordFormPage,
    String password,
    String email,
  ) async {
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    //await CommonUtil.tapButton($, targetNameButton: 'Account setting');
    await CommonUtil.tapButton($, targetNameButton: 'Accounts Center');
    await $.pumpAndSettle();
    await CommonUtil.tapIconCheckboxSelected($);
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Email');
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Continue');
    await $.pumpAndSettle();
    await passwordFormPage.inputCurrentPassword($, password);
    await CommonUtil.fillTextInput($, targetNameInput: 'Email', text: email);
    await CommonUtil.tapButton($, targetNameButton: 'Continue');
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Get OTP');
    await $.pump();
    final otpEmailData = await findDbUtil.getOtpByEmail(email, isGetLatest: true);
    await CommonUtil.fillOtp($, targetNameType: PinCodeTextField, text: otpEmailData);
    await $("You've changed your email.").waitUntilExists();
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    //await CommonUtil.tapNavigationBarWith($, 'Contact');
    //await $.pumpAndSettle();
  }

  Future<void> proceedChangePassword(
    $,
    FindDbUtil findDbUtil,
    PasswordFormPage passwordFormPage,
    String currentPassword,
    String newPassword,
    String confirmNewPassword,
  ) async {
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    //await CommonUtil.tapButton($, targetNameButton: 'Account setting');
    await CommonUtil.tapButton($, targetNameButton: 'Accounts Center');
    await $.pumpAndSettle();
    await CommonUtil.tapIconCheckboxSelected($);
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Password');
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Change to new password');
    await $.pumpAndSettle();
    await passwordFormPage.inputCurrentPassword($, currentPassword);
    await passwordFormPage.proceedNewPassword($, newPassword, confirmNewPassword);
    await $("You've changed password.").waitUntilExists();
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
  }

  Future<void> proceedDeleteAccount($, String password) async {
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await CommonUtil.tapButton($, targetNameButton: 'Account setting');
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Delete Account');
    await $.pumpAndSettle();
    await CommonUtil.fillTextInput($, targetNameInput: 'Password', text: password);
    await CommonUtil.tapButton($, targetNameButton: 'Continue');
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Delete');
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Confirm');
    await $("Get Started").waitUntilExists();
    await $.pumpAndSettle();
  }

  Future<void> proceedUserSetting($, userSettingByMap) async {
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    final parentPopupMenuFinder = find.byType(Column);
    final targetTextFinder = find.descendant(of: parentPopupMenuFinder, matching: find.byType(ListTile));
    final targetProfileFinder = find.descendant(of: targetTextFinder, matching: find.byType(CircleAvatar));
    await CommonUtil.tapButton($, targetNameButton: targetProfileFinder);
    await $.pump();
    if (userSettingByMap.isSelectEditProfile) {
      await proceedEditUserProfile($, userSettingByMap);
      await CommonUtil.tapButton($, targetNameButton: 'Back');
      await $.pump();
    }
    await CommonUtil.tapButton($, targetNameButton: find.byType(Icon));
  }

  Future<void> proceedEditUserProfile($, userSettingByMap) async {
    await CommonUtil.tapButton($, targetNameButton: 'Edit');
    await $.pump();
    if (userSettingByMap.isCheckProfileName) {
      await CommonUtil.tapButton($, targetNameButton: 'Name');
      await $.pump();
      await CommonUtil.fillTextInput($, targetNameInput: 'Name', text: userSettingByMap.userSettingProfileName);
      await $.pump(const Duration(seconds: 1));
      await CommonUtil.tapButton($, targetNameButton: 'Done');
      await $.pump();
      await $(find.text(userSettingByMap.userSettingProfileName)).waitUntilExists();
    }
    if (userSettingByMap.isCheckUchatId) {
      await CommonUtil.tapButton($, targetNameButton: 'UChat ID');
      await $.pump();
      await CommonUtil.fillTextInput($, targetNameInput: 'UChat ID', text: userSettingByMap.userSettingUchatId);
      await $.pump(const Duration(seconds: 1));
      await CommonUtil.tapButton($, targetNameButton: 'Done');
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: 'Confirm');
      await $.pump();
      await $(find.text(userSettingByMap.userSettingUchatId)).waitUntilExists();
    }
    if (userSettingByMap.isCheckStatus) {
      await CommonUtil.tapButton($, targetNameButton: 'Status');
      await $.pump();
      await CommonUtil.fillTextInput($, targetNameInput: 'Status', text: userSettingByMap.userSettingStatus);
      await $.pump(const Duration(seconds: 1));
      await CommonUtil.tapButton($, targetNameButton: 'Done');
      await $.pump();
      await $(find.text(userSettingByMap.userSettingStatus)).waitUntilExists();
    }
    if (userSettingByMap.isCheckDateOfBirth) {
      await CommonUtil.fillDateOfBirth($, targetDobInput: userSettingByMap.userSettingDateOfBirth);
      await $.pump();
      DateTime parsedDate = DateFormat('d MMM yyyy').parse(userSettingByMap.userSettingDateOfBirth);
      final targetDob = DateFormat('MMM d, yyyy').format(parsedDate);
      await $(targetDob).waitUntilExists();
    }
  }

  Future<void> proceedHidePhoneNumber($) async {
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    final parentPopupMenuFinder = find.byType(Column);
    final targetTextFinder = find.descendant(of: parentPopupMenuFinder, matching: find.byType(ListTile));
    final targetProfileFinder = find.descendant(of: targetTextFinder, matching: find.byType(CircleAvatar));
    await CommonUtil.tapButton($, targetNameButton: targetProfileFinder);
    await $.pump();
    final targetFinder = find.ancestor(of: find.text('Hide phone number'), matching: find.byType(ListTile));
    await CommonUtil.tapToggleButton($, targetNameFinder: targetFinder);
    await CommonUtil.tapButton($, targetNameButton: find.byType(Icon));
  }

  Future<void> proceedPasscode($, userSettingByMap) async {
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    final parentPopupMenuFinder = find.byType(Column);
    final targetTextFinder = find.descendant(of: parentPopupMenuFinder, matching: find.byType(ListTile));
    final targetProfileFinder = find.descendant(of: targetTextFinder, matching: find.byType(CircleAvatar));
    await CommonUtil.tapButton($, targetNameButton: targetProfileFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'PIN lock');
    await $.pump();
    if (userSettingByMap.isSetFirstPinCode) {
      final targetNameFinder = find.ancestor(of: find.text('PIN lock'), matching: find.byType(PasscodeToggleScreen));
      await CommonUtil.tapToggleButton($, targetNameFinder: targetNameFinder);
      await $.pump();
      await CommonUtil.tapPasscode($, targetPasscode: userSettingByMap.firstPinCode);
      await $.pump();
      await CommonUtil.tapPasscode($, targetPasscode: userSettingByMap.confirmFirstPinCode);
      await $.pump();
    }
    if (userSettingByMap.isSetNewPinCode) {
      await CommonUtil.tapButton($, targetNameButton: 'Set a new PIN');
      await $.pump();
      await CommonUtil.tapPasscode($, targetPasscode: userSettingByMap.newPinCode);
      await $.pump();
      await CommonUtil.tapPasscode($, targetPasscode: userSettingByMap.confirmNewPinCode);
      await $.pump();
    }
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: find.byType(Icon));
    await $.pump();
  }

  Future<void> proceedQrcode($, userSettingByMap) async {
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    final parentPopupMenuFinder = find.byType(Column);
    final targetTextFinder = find.descendant(of: parentPopupMenuFinder, matching: find.byType(ListTile));
    final targetProfileFinder = find.descendant(of: targetTextFinder, matching: find.byType(CircleAvatar));
    await CommonUtil.tapButton($, targetNameButton: targetProfileFinder);
    await $.pump();
    await CommonUtil.tapIconQrcode($);
    await $.pump();
    if (userSettingByMap.isSaveQrcode) {
      await CommonUtil.tapButton($, targetNameButton: 'Save');
      if (await $.platform.mobile.isPermissionDialogVisible()) {
        if (Platform.isIOS) {
          await $.platform.ios.tap('Allow Access to All Photos');
        } else {
          await $.platform.mobile.tap(Selector(text: 'Allow all'));
        }
      }
      await CommonUtil.tapIconClose($);
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: find.byType(Icon));
    }
  }
}
