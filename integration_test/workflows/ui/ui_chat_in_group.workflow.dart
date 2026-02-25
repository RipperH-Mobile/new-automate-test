import 'package:flutter_test/flutter_test.dart';

import '../../pages/login.page.dart';
import '../../pages/chat_message.page.dart';
import '../../utils/common.util.dart';

class UiChatInGroupWorkflow {
  Future<void> proceedChatInGroup($, LoginPage loginPage, ChatMessagePage chatPage, dynamic config) async {
    if (config.isLoginByOwner) {
      await _performChatAction(
        $,
        loginPage: loginPage,
        chatPage: chatPage,
        isLoginByPhone: config.isLoginByPhone ?? true,
        phone: config.loginByOwnerPhone,
        password: config.loginByOwnerPassword,
        rawMessageList: config.ownerMessageList,
        groupName: config.groupName,
      );
    }
    if (config.isLoginByAdmin) {
      await _performChatAction(
        $,
        loginPage: loginPage,
        chatPage: chatPage,
        isLoginByPhone: config.isLoginByPhone ?? true,
        phone: config.loginByAdminPhone,
        password: config.loginByAdminPassword,
        rawMessageList: config.adminMessageList,
        groupName: config.groupName,
      );
    }
    if (config.isLoginByMember) {
      await _performChatAction(
        $,
        loginPage: loginPage,
        chatPage: chatPage,
        isLoginByPhone: config.isLoginByPhone ?? true,
        phone: config.loginByMemberPhone,
        password: config.loginByMemberPassword,
        rawMessageList: config.memberMessageList,
        groupName: config.groupName,
      );
    }
  }

  Future<void> _performChatAction(
    $, {
    required LoginPage loginPage,
    required ChatMessagePage chatPage,
    required bool isLoginByPhone,
    required String phone,
    required String password,
    required String rawMessageList,
    required String groupName,
  }) async {
    // 1. Login
    await loginPage.proceedLogin(
      isPhoneLogin: isLoginByPhone,
      phoneWithoutCode: await CommonUtil.convertE164ToNational(phone),
      phoneWithCode: phone,
      password: password,
    );

    // 2. Navigate to Contact
    await CommonUtil.tapNavigationBarWith($, 'Contact');
    await $.pump();

    // 3. Process Messages
    if (rawMessageList.isNotEmpty) {
      List<String> messages = rawMessageList.split('|');
      for (var message in messages) {
        if (message.trim().isNotEmpty) {
          await chatPage.proceedChatWithMessage($, false, groupName, message);
        }
      }
    }

    // 4. Logout
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await loginPage.proceedLogout($);
  }
}
