import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../utils/common.util.dart';
import '../../pages/password_form.page.dart';

class UiDeleteAccountWorkflow {
  Future<void> proceedDeleteAccount($, String password) async {
    PasswordFormPage passwordFormPage = new PasswordFormPage();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    final parentPopupMenuFinder = find.byType(Column);
    final targetTextFinder = find.descendant(of: parentPopupMenuFinder, matching: find.byType(ListTile));
    //final targetProfileFinder = find.descendant(of: targetTextFinder, matching: find.text('Account setting'));
    final targetProfileFinder = find.descendant(of: targetTextFinder, matching: find.text('Accounts Center'));
    await CommonUtil.tapButton($, targetNameButton: targetProfileFinder);
    await $.pump();
    await CommonUtil.tapIconCheckboxSelected($);
    await $.pump();
    await $('Delete Account').scrollTo();
    await CommonUtil.tapButton($, targetNameButton: 'Delete Account');
    await passwordFormPage.inputCurrentPassword($, password);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Delete');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Confirm');
    await $.pump();
  }
}
