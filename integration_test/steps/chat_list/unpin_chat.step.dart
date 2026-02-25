import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/login.page.dart';
import '../../pages/register.page.dart';
import '../../pages/password_form.page.dart';
import '../../pages/chat_message.page.dart';
import '../../pages/account_setting.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

class UnpinChatStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final RegisterPage _registerPage = RegisterPage();
  final PasswordFormPage _passwordPage = PasswordFormPage();
  final ChatMessagePage _chatPage = ChatMessagePage();
  final AccountSettingPage _settingPage = AccountSettingPage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = UnpinChatTestConfig.fromRow(dataRow);

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

      // 4. Pin chat
      await _performPinChat($, config);

      // 5. Execute test
      await _performAction($, config);

      // 6. Expected
      if (config.isExpectedSuccess) {
        await _performExpectedSuccess($, config);
      } else {
        await _performExpectedFail($, config);
      }

      dataRow['actual_result'] = 'PASSED';
    } catch (e, stackTrace) {
      debugPrint('---error---$e\n$stackTrace');
      dataRow['actual_result'] = 'FAILED';
    } finally {
      // 4. Cleanup (Delete Account)
      if (config.isDeleteAfterRun) {
        await _performCleanup($, config);
      }

      // Update Metadata
      await _updateResultMetadata(dataRow);
      resultsData.add(dataRow);
    }
    return resultsData;
  }

  // --- Sub-routines ---

  Future<void> _performRegistration($, UnpinChatTestConfig config) async {
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

  Future<void> _performAddFriendAndChat($, UnpinChatTestConfig config) async {
    final dataSetList = config.addFriendDetail.split(',');
    for (final dataSet in dataSetList) {
      final fields = dataSet.trim().split('|');
      if (fields.length < 4) continue;

      final inputPhoneWithCode = fields[0];
      final inputPassword = fields[1];
      final inputUchatId = fields[2];
      final inputMessage = fields[3];
      final inputPhoneNational = await CommonUtil.convertE164ToNational(inputPhoneWithCode);

      // Add Friend & Send Message
      await _chatPage.proceedAddFriend($, inputPhoneNational);
      await _chatPage.proceedChatWithMessage($, false, inputUchatId, inputMessage);
    }
  }

  Future<void> _performPinChat($, UnpinChatTestConfig config) async {
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    final friendNameFinder = find.textContaining(config.pinChatTarget);
    await CommonUtil.dragLeft($, friendNameFinder);
    await CommonUtil.tapButton($, targetNameButton: 'More');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Pin');
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performAction($, UnpinChatTestConfig config) async {
    await _loginUser($, config.loginByMePhone, config.loginByMePassword, config.isLoginByPhone);
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    if (config.isUnpinChat) {
      final friendNameFinder = find.textContaining(config.unpinChatTarget);
      await CommonUtil.dragLeft($, friendNameFinder);
      await CommonUtil.tapButton($, targetNameButton: 'More');
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: 'Unpin');
      await $.pump();
    }
  }

  Future<void> _performExpectedSuccess($, UnpinChatTestConfig config) async {
    await $.pump(const Duration(seconds: 1));
    final iconPinnedSvgFinder = find.byWidgetPredicate((Widget widget) {
      if (widget is SvgPicture && widget.bytesLoader is SvgAssetLoader) {
        final SvgAssetLoader loader = widget.bytesLoader as SvgAssetLoader;
        return loader.assetName == 'assets/vectors/icon_pinned.svg';
      }
      return false;
    });
    final friendNameFinder = find.textContaining(config.unpinChatTarget);
    final columnFinder = find.ancestor(of: friendNameFinder, matching: find.byType(Column));
    final nestedFinder = $(columnFinder).$(iconPinnedSvgFinder);
    expect(nestedFinder, findsNothing);

    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedFail($, UnpinChatTestConfig config) async {}

  Future<void> _performCleanup($, UnpinChatTestConfig config) async {
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

class UnpinChatTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool isLoginByPhone;
  final String loginByMePhone;
  final String loginByMePassword;
  final String loginByFriendPhone;
  final String loginByFriendPassword;
  final bool isAddFriend;
  final String addFriendDetail;
  final String pinChatTarget;
  final bool isUnpinChat;
  final String unpinChatTarget;
  final String expectedNavigatePage;
  final bool isExpectedSuccess;
  final String expectedMessage;

  // Data lists for registration
  final List<String> regPhones;
  final List<String> regEmails;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  UnpinChatTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        loginByMePhone = row['login_by_me_phone_number'] ?? '',
        loginByMePassword = row['login_by_me_password'] ?? '',
        loginByFriendPhone = row['login_by_friend_phone_number'] ?? '',
        loginByFriendPassword = row['login_by_friend_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        pinChatTarget = row['pin_chat_target'] ?? '',
        isUnpinChat = CommonUtil.convertStringToBoolean(row['is_unpin_chat']),
        unpinChatTarget = row['unpin_chat_target'] ?? '',
        expectedMessage = row['expected_message'] ?? '',
        expectedNavigatePage = row['expected_navigate_page'] ?? '',
        isExpectedSuccess = CommonUtil.convertStringToBoolean(row['expected_result']),
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
