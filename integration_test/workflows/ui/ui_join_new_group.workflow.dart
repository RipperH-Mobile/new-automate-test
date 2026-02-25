import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../pages/login.page.dart';
import '../../utils/common.util.dart';

class UiJoinNewGroupWorkflow {
  Future<void> proceedJoinNewGroup($, LoginPage loginPage, dynamic config) async {
    if (config?.loginByAdminPhone?.isNotEmpty ?? false) {
      await _performJoinAction(
        $,
        loginPage: loginPage,
        isLoginByPhone: config.isLoginByPhone ?? true,
        phone: config.loginByAdminPhone,
        password: config.loginByAdminPassword,
        groupName: config.groupName,
      );
    }
    if (config?.loginByMemberPhone?.isNotEmpty ?? false) {
      await _performJoinAction(
        $,
        loginPage: loginPage,
        isLoginByPhone: config.isLoginByPhone ?? true,
        phone: config.loginByMemberPhone,
        password: config.loginByMemberPassword,
        groupName: config.groupName,
      );
    }
  }

  Future<void> _performJoinAction(
    $, {
    required LoginPage loginPage,
    required bool isLoginByPhone,
    required String phone,
    required String password,
    required String groupName,
  }) async {
    // 1. Login
    await loginPage.proceedLogin(
      isPhoneLogin: isLoginByPhone,
      phoneWithoutCode: await CommonUtil.convertE164ToNational(phone),
      phoneWithCode: phone,
      password: password,
    );

    // 2. Navigate to Notifications
    await CommonUtil.tapNavigationBarWith($, 'Notifications');

    // 3. Find Group & Join Button
    final groupNameFinder = find.textContaining(groupName);
    final rowFinder = find.ancestor(of: groupNameFinder, matching: find.byType(Row));
    final joinButtonFinder = $(rowFinder).$('Join').first;
    expect(joinButtonFinder, findsOneWidget);

    // 4. Tap Join
    await CommonUtil.tapButton($, targetNameButton: joinButtonFinder);

    // 5. Logout
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await loginPage.proceedLogout($);
  }
}
