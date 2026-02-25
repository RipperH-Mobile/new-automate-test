import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/login.page.dart';
import '../../pages/register.page.dart';
import '../../pages/chat_message.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_create_new_group.workflow.dart';
import '../../workflows/ui/ui_join_new_group.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

class GroupSystemMessageStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiCreateNewGroupWorkflow _createNewGroupWorkflow = UiCreateNewGroupWorkflow();
  final UiJoinNewGroupWorkflow _joinNewGroupWorkflow = UiJoinNewGroupWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final RegisterPage _registerPage = RegisterPage();
  final ChatMessagePage _chatPage = ChatMessagePage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = GroupSystemMessageTestConfig.fromRow(dataRow);

    try {
      // 1. Registration Flow
      if (config.isRegister) {
        await _performRegistration($, config);
      }

      // 2. Login Main User
      await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);

      // 3. Add Friend Flow
      if (config.isAddFriend) {
        await _performAddFriends($, config);
      }

      // 4. Create Group Flow
      if (config.isCreateGroup) {
        await _performCreateGroup($, config);
        await CommonUtil.tapNavigationBarWith($, 'Menu');
        await _loginPage.proceedLogout($);
        await _performJoinGroup($, _loginPage, config);
      }

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
      // 7. Cleanup (Delete Account)
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

  Future<void> _performRegistration($, GroupSystemMessageTestConfig config) async {
    for (int i = 0; i < config.regPhones.length; i++) {
      final currentPhone = config.getVal(config.regPhones, i);
      final sessionMap = {
        'phoneWithCode': currentPhone,
        'phoneWithoutCode': await CommonUtil.convertE164ToNational(currentPhone),
        'profileName': config.getVal(config.regNames, i),
        'password': config.getVal(config.regPasswords, i),
        'confirmPassword': config.getVal(config.regPasswords, i),
        'uchatId': config.getVal(config.regUchatIds, i),
        'isLoginByPhone': true,
      };
      await _apiCreateAccountWorkflow.createAccount(currentPhone, config.getVal(config.regNames, i),
          config.getVal(config.regUchatIds, i), config.getVal(config.regPasswords, i));
    }
  }

  Future<void> _performAddFriends($, GroupSystemMessageTestConfig config) async {
    final dataSetList = config.addFriendDetail.split(',');
    for (final dataSet in dataSetList) {
      final fields = dataSet.trim().split('|');
      if (fields.length < 3) continue;
      final inputPhoneWithCode = fields[0];
      final inputPassword = fields[1];
      final inputUchatId = fields[2];
      final inputPhoneNational = await CommonUtil.convertE164ToNational(inputPhoneWithCode);
      await _chatPage.proceedAddFriend($, inputPhoneNational);
    }
  }

  Future<void> _performCreateGroup($, GroupSystemMessageTestConfig config) async {
    await _createNewGroupWorkflow.proceedCreateGroup($, config.addMemberDetail, config.groupName);
  }

  Future<void> _performJoinGroup($, LoginPage _loginPage, GroupSystemMessageTestConfig config) async {
    await _joinNewGroupWorkflow.proceedJoinNewGroup($, _loginPage, config);
  }

  Future<void> _performAction($, GroupSystemMessageTestConfig config) async {
    if (config.isLeaveGroup) {
      await _loginUser($, config.loginByMemberPhone, config.loginByMemberPassword, true);
      await CommonUtil.tapNavigationBarWith($, 'Contact');
      await $.pump();
      final friendNameFinder = find.textContaining(config.groupName);
      await CommonUtil.dragLeft($, friendNameFinder);
      await CommonUtil.tapButton($, targetNameButton: 'Leave');
      await CommonUtil.tapButton($, targetNameButton: 'Leave');
      await CommonUtil.tapNavigationBarWith($, 'Menu');
      await _loginPage.proceedLogout($);
    }
    await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    await $.pump();
    final groupNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
    await $.pump();
  }

  Future<void> _performExpectedSuccess($, GroupSystemMessageTestConfig config) async {
    final parsedText = $(ParsedText).first;
    final ParsedText systemText = $.tester.widget<ParsedText>(parsedText);
    final String expectedText = systemText.text ?? "";
    expect(
      expectedText,
      allOf(contains(config.memberTarget), contains(config.expectedMessage)),
    );
    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedFail($, GroupSystemMessageTestConfig config) async {}

  Future<void> _performCleanup($, GroupSystemMessageTestConfig config) async {
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

    // final targets = config.regPhones;
    // final passwords = config.regPasswords;

    // for (int i = 0; i < targets.length; i++) {
    //   final currentPhone = config.getVal(targets, i);
    //   final password = config.getVal(passwords, i);

    //   if (currentPhone.isEmpty) continue;

    //   // Ensure logged in before delete
    //   await _loginUser($, currentPhone, password, true);
    //   await CommonUtil.tapNavigationBarWith($, 'Contact');
    //   final groupNameFinder = find.textContaining(config.groupName);
    //   await CommonUtil.dragLeft($, groupNameFinder);
    //   await CommonUtil.tapButton($, targetNameButton: 'Leave');
    //   await $.pump();
    //   await CommonUtil.tapButton($, targetNameButton: 'Leave');
    //   await $.pump();
    //   await _deleteWorkflow.proceedDeleteAccount($, password);
    // }
  }

  Future<void> _loginUser($, String phoneWithCode, String password, bool isPhoneLogin) async {
    await _loginPage.proceedLogin(
      isPhoneLogin: isPhoneLogin,
      phoneWithoutCode: await CommonUtil.convertE164ToNational(phoneWithCode),
      phoneWithCode: phoneWithCode,
      password: password,
    );
  }

  Future<void> _updateResultMetadata(Map<String, dynamic> dataRow) async {
    final packageInfo = await CommonUtil.getActualCurrentAppVersion();
    final osVersion = await CommonUtil.getActualDeviceInfo();
    dataRow['actual_version'] = 'app version ${packageInfo.version} | $osVersion | ${DateTime.now()}';
  }
}

class GroupSystemMessageTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool? isLoginByPhone;

  // Login Details
  final String loginByOwnerPhone;
  final String loginByOwnerPassword;
  final String loginByAdminPhone;
  final String loginByAdminPassword;
  final String loginByMemberPhone;
  final String loginByMemberPassword;

  // Feature Flags & Details
  final bool isAddFriend;
  final String addFriendDetail;
  final bool isCreateGroup;
  final String groupName;
  final String addMemberDetail;

  final bool isLeaveGroup;
  final String memberTarget;

  // Expectations
  final String expectedNavigatePage;
  final bool isExpectedSuccess;
  final String expectedMessage;

  // Registration Data Lists
  final List<String> regPhones;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  GroupSystemMessageTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        loginByOwnerPhone = row['login_by_owner_phone_number'] ?? '',
        loginByOwnerPassword = row['login_by_owner_password'] ?? '',
        loginByAdminPhone = '',
        loginByAdminPassword = '',
        loginByMemberPhone = row['login_by_member_phone_number'] ?? '',
        loginByMemberPassword = row['login_by_member_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        isCreateGroup = CommonUtil.convertStringToBoolean(row['is_create_group']),
        groupName = row['group_name'] ?? '',
        addMemberDetail = row['add_member_detail'] ?? '',
        isLeaveGroup = CommonUtil.convertStringToBoolean(row['is_leave_group']),
        memberTarget = row['member_target'] ?? '',
        expectedNavigatePage = row['expected_navigate_page'] ?? '',
        isExpectedSuccess = CommonUtil.convertStringToBoolean(row['expected_result']),
        expectedMessage = row['expected_message'] ?? '',
        regPhones = row['register_phone_number']?.split('|') ?? [],
        regNames = row['register_profile_name']?.split('|') ?? [],
        regPasswords = row['register_password']?.split('|') ?? [],
        regUchatIds = row['register_uchat_id']?.split('|') ?? [];

  String getVal(List<String> list, int index) {
    if (list.isEmpty) return "";
    return index >= list.length ? list.last : list[index];
  }
}
