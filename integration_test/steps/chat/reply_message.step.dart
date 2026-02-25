import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_regular_text.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/login.page.dart';
import '../../pages/password_form.page.dart';
import '../../pages/chat_message.page.dart';
import '../../pages/account_setting.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

class ReplyMessageStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final PasswordFormPage _passwordPage = PasswordFormPage();
  final ChatMessagePage _chatPage = ChatMessagePage();
  final AccountSettingPage _settingPage = AccountSettingPage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = ReplyMessageTestConfig.fromRow(dataRow);

    try {
      // 1. Registration Flow
      if (config.isRegister) {
        await _performRegistration($, config);
      }

      // 2. Login Main User
      await _loginUser($, config.loginByMePhone, config.loginByMePassword, config.isLoginByPhone);

      // 3. Add Friend & Chat Verification Flow
      if (config.isAddFriend) {
        await _performAddFriendAndChat($, config);
      }

      // 4. Reply Workflow (Add Friend -> Chat -> Reply)
      if (config.isReplyMessage) {
        await _performReplyMessage($, config);
      }

      dataRow['actual_result'] = 'PASSED';
    } catch (e, stackTrace) {
      debugPrint('---error---$e\n$stackTrace');
      dataRow['actual_result'] = 'FAILED';
    } finally {
      try {
        // 5. Cleanup (Delete Account)
        if (config.isDeleteAfterRun) {
          await _performCleanup($, config);
        }
      } catch (e, stackTrace) {
        debugPrint('---error delete account---$e\n$stackTrace');
      }

      // Update Metadata
      await _updateResultMetadata(dataRow);
      resultsData.add(dataRow);
    }
    return resultsData;
  }

  // --- Sub-routines ---

  Future<void> _performRegistration($, ReplyMessageTestConfig config) async {
    for (int i = 0; i < config.regPhones.length; i++) {
      final currentPhone = config.getVal(config.regPhones, i);
      final sessionMap = {
        'phoneWithCode': currentPhone,
        'phoneWithoutCode': await CommonUtil.convertE164ToNational(currentPhone),
        'email': config.getVal(config.regEmails, i),
        'profileName': config.getVal(config.regNames, i),
        'password': config.getVal(config.regPasswords, i),
        'confirmPassword': config.getVal(config.regPasswords, i),
        'uchatId': config.getVal(config.regUchatIds, i),
        'isLoginByPhone': config.isLoginByPhone,
      };

      await _apiCreateAccountWorkflow.createAccount(currentPhone, config.getVal(config.regNames, i),
          config.getVal(config.regUchatIds, i), config.getVal(config.regPasswords, i));

      if (!config.isLoginByPhone) {
        await _settingPage.proceedAddEmail(
          $,
          _findDbUtil,
          _passwordPage,
          sessionMap['password'] as String,
          sessionMap['email'] as String,
        );
      }
    }
  }

  Future<void> _performAddFriendAndChat($, ReplyMessageTestConfig config) async {
    final dataSetList = config.addFriendDetail.split(',');
    for (final dataSet in dataSetList) {
      final fields = dataSet.trim().split('|');
      if (fields.length < 3) continue;
      final inputPhoneWithCode = fields[0];
      final inputPassword = fields[1];
      final inputUchatId = fields[2];
      final inputPhoneNational = await CommonUtil.convertE164ToNational(inputPhoneWithCode);

      // Add Friend
      await _chatPage.proceedAddFriend($, inputPhoneNational);

      // Send Message
      List<String> messages = config.messageList.split('|');
      for (var message in messages) {
        if (message.trim().isNotEmpty) {
          await _chatPage.proceedChatWithMessage($, false, inputUchatId, message);
        }
      }
      await CommonUtil.tapNavigationBarWith($, 'Menu');
      await _loginPage.proceedLogout($);
    }
  }

  Future<void> _performReplyMessage($, ReplyMessageTestConfig config) async {
    await _loginUser($, config.loginByMePhone, config.loginByMePassword, config.isLoginByPhone);
    await CommonUtil.tapNavigationBarWith($, 'Chat');

    // Enter Chat Room to Perform Reply
    var friendNameFinder = find.textContaining(config.loginByFriendProfileName);
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    await $.pump();

    final messageFinder = find.ancestor(
      of: find.text(config.replyMessageTarget),
      matching: find.byType(MessageTypeRegularText),
    );

    await CommonUtil.tapButtonLongPressV2($, targetNameButton: messageFinder);
    await CommonUtil.tapButton($, targetNameButton: 'Reply');
    await $.pump();
    await CommonUtil.tapButtonLongPressV1($, targetNameButton: $(TextField));
    await $(TextField).tap();
    await $(TextField).enterText(config.newMessage);
    await CommonUtil.tapIconSendMessage($);
    await $.pump();
    await CommonUtil.tapIconBack($);
    //await $.pump();

    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);

    // Login User B (Friend)
    await _loginUser($, config.loginByFriendPhone, config.loginByFriendPassword, config.isLoginByPhone);

    // Verify Message on Destination
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    friendNameFinder = find.textContaining(config.loginByMeProfileName);
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    await $.pump();
    expect($(config.newMessage), findsOneWidget);
    await CommonUtil.tapIconBack($);
    //await $.pump();

    // Logout User B
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performCleanup($, ReplyMessageTestConfig config) async {
    List<String> phoneList = [];
    phoneList.addAll(config.regPhones);
    final getListDetailAccounts = await _findDbUtil.getListDetailByPhoneInAccount(phoneList);
    List<Map<String, dynamic>> reusableAccountList = [];
    if (getListDetailAccounts != null && getListDetailAccounts is List) {
      for (int i = 0; i < config.regPhones.length; i++) {
        var dbRecord = getListDetailAccounts[i];
        reusableAccountList.add({
          'documentId': dbRecord['_id'],
          'username': '',
          'hashedPassword': '',
          'phoneNumber': '',
          'displayName': 'Deleted User',
          'deleted': true
        });
      }
    }
    if (getListDetailAccounts.isNotEmpty) {
      await _updateDbUtil.updateListReuseDeletedUserInAccount(reusableAccountList);
      debugPrint('Updated ${reusableAccountList.length} users successfully.');
    }

    // for (int i = 0; i < config.regPhones.length; i++) {
    //   final currentPhone = config.getVal(config.regPhones, i);
    //   final phoneWithoutCode = await CommonUtil.convertE164ToNational(currentPhone);
    //   final password = config.getVal(config.regPasswords, i);

    //   // Login to delete
    //   await _loginUser($, currentPhone, password, config.isLoginByPhone);
    //   await _deleteWorkflow.proceedDeleteAccount($, password);
    // }
  }

  Future<void> _loginUser($, String phoneWithCode, String password, bool isPhoneLogin) async {
    await _loginPage.proceedLogin(
      isPhoneLogin: isPhoneLogin,
      phoneWithoutCode: await CommonUtil.convertE164ToNational(phoneWithCode),
      phoneWithCode: await CommonUtil.convertE164ToNational(phoneWithCode),
      password: password,
    );
  }

  Future<void> _updateResultMetadata(Map<String, dynamic> dataRow) async {
    final packageInfo = await CommonUtil.getActualCurrentAppVersion();
    final osVersion = await CommonUtil.getActualDeviceInfo();
    dataRow['actual_version'] = 'app version ${packageInfo.version} | $osVersion | ${DateTime.now()}';
  }
}

class ReplyMessageTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool isLoginByPhone;
  final String loginByMePhone;
  final String loginByMeProfileName;
  final String loginByMePassword;
  final String loginByFriendPhone;
  final String loginByFriendProfileName;
  final String loginByFriendPassword;
  final bool isAddFriend;
  final String addFriendDetail;

  // Specific for Reply Test
  final String messageList;
  final bool isReplyMessage;
  final String replyMessageTarget;
  final String newMessage;
  final String expectedNavigatePage;
  final bool expectedResult;
  final String expectedMessage;

  // Registration Data Lists
  final List<String> regPhones;
  final List<String> regEmails;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  ReplyMessageTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        loginByMePhone = row['login_by_me_phone_number'] ?? '',
        loginByMeProfileName = row['login_by_me_profile_name'] ?? '',
        loginByMePassword = row['login_by_me_password'] ?? '',
        loginByFriendPhone = row['login_by_friend_phone_number'] ?? '',
        loginByFriendProfileName = row['login_by_friend_profile_name'] ?? '',
        loginByFriendPassword = row['login_by_friend_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        messageList = row['message_list'] ?? '',

        // Reply Specific
        isReplyMessage = CommonUtil.convertStringToBoolean(row['is_reply_message']),
        replyMessageTarget = row['reply_message_target'] ?? '',
        newMessage = row['new_message'] ?? '',
        expectedNavigatePage = row['expected_navigate_page'] ?? '',
        expectedResult = CommonUtil.convertStringToBoolean(row['expected_result']),
        expectedMessage = row['expected_message'] ?? '',

        // Register Arrays
        regPhones = row['register_phone_number']?.split('|') ?? [],
        regEmails = row['register_email']?.split('|') ?? [],
        regNames = row['register_profile_name']?.split('|') ?? [],
        regPasswords = row['register_password']?.split('|') ?? [],
        regUchatIds = row['register_uchat_id']?.split('|') ?? [];

  String getVal(List<String> list, int index) {
    if (list.isEmpty) return "";
    return index >= list.length ? list.last : list[index];
  }
}
