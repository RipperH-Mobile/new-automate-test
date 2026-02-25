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

class GroupMemberManagementStep {
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
    final config = GroupMemberManagementTestConfig.fromRow(dataRow);

    try {
      // 1. Registration Flow
      if (config.isRegister) {
        await _performRegistration($, config);
      }

      // 2. Login Main User (Owner/Admin)
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
        if (config.whoAssignToAdmin.isNotEmpty ?? false) {
          await _performAssignAdmin($, config);
          if (config.expectedLoginByOwnerPhone.isNotEmpty) {
            await _loginUser($, config.expectedLoginByOwnerPhone, config.expectedLoginByOwnerPassword, true);
          } else if (config.expectedLoginByAdminPhone.isNotEmpty) {
            await _loginUser($, config.expectedLoginByAdminPhone, config.expectedLoginByAdminPassword, true);
          } else if (config.expectedLoginByMemberPhone.isNotEmpty) {
            await _loginUser($, config.expectedLoginByMemberPhone, config.expectedLoginByMemberPassword, true);
          }
          final dataSetList = config.addFriendDetail.split(',');
          for (final dataSet in dataSetList) {
            final fields = dataSet.trim().split('|');
            if (fields.length < 3) continue;
            final inputPhoneWithCode = fields[0];
            final inputUchatId = fields[2];
            if (inputUchatId == config.whoAssignToAdmin) continue;
            final inputPhoneNational = await CommonUtil.convertE164ToNational(inputPhoneWithCode);
            await _chatPage.proceedAddFriend($, inputPhoneNational);
            await CommonUtil.tapNavigationBarWith($, 'Menu');
            await _loginPage.proceedLogout($);
          }
        }
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

  Future<void> _performRegistration($, GroupMemberManagementTestConfig config) async {
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

  Future<void> _performAddFriends($, GroupMemberManagementTestConfig config) async {
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

  Future<void> _performCreateGroup($, GroupMemberManagementTestConfig config) async {
    await _createNewGroupWorkflow.proceedCreateGroup($, config.addMemberDetail, config.groupName);
  }

  Future<void> _performJoinGroup($, LoginPage _loginPage, GroupMemberManagementTestConfig config) async {
    await _joinNewGroupWorkflow.proceedJoinNewGroup($, _loginPage, config);
  }

  Future<void> _performAssignAdmin($, GroupMemberManagementTestConfig config) async {
    await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);
    await CommonUtil.tapNavigationBarWith($, 'Contact');
    await $.pump();
    final groupNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
    final targetButtonText = 'Chat';
    final targetButtonFinder = find.text(targetButtonText);
    bool found = false;
    for (int i = 0; i < 50; i++) {
      await $.pump(const Duration(seconds: 3));
      if (find.text(targetButtonText).evaluate().isNotEmpty) {
        found = true;
        break;
      }
    }
    if (!found) {
      await $.pumpAndSettle();
    }
    await CommonUtil.tapButton($, targetNameButton: targetButtonFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Administrators');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Add');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: config.whoAssignToAdmin);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Done');
    await $.pump(const Duration(seconds: 1));
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performAction($, GroupMemberManagementTestConfig config) async {
    if (config.expectedLoginByOwnerPhone.isNotEmpty) {
      await _loginUser($, config.expectedLoginByOwnerPhone, config.expectedLoginByOwnerPassword, true);
    } else if (config.expectedLoginByAdminPhone.isNotEmpty) {
      await _loginUser($, config.expectedLoginByAdminPhone, config.expectedLoginByAdminPassword, true);
    } else if (config.expectedLoginByMemberPhone.isNotEmpty) {
      await _loginUser($, config.expectedLoginByMemberPhone, config.expectedLoginByMemberPassword, true);
    }
    await CommonUtil.tapNavigationBarWith($, 'Contact');
    await $.pump();
    final friendNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    final targetButtonText = 'Chat';
    final targetButtonFinder = find.text(targetButtonText);
    bool found = false;
    for (int i = 0; i < 50; i++) {
      await $.pump(const Duration(seconds: 3));
      if (find.text(targetButtonText).evaluate().isNotEmpty) {
        found = true;
        break;
      }
    }
    if (!found) {
      await $.pumpAndSettle();
    }
    await CommonUtil.tapButton($, targetNameButton: targetButtonFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Member');
    await $.pump();
    if (config.isAddMember) {
      await CommonUtil.tapButton($, targetNameButton: 'Invite');
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: config.targetAction);
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: 'Done');
      await $.pump();
    } else if (config.isRemoveMember) {
      final memberNameFinder = find.textContaining(config.targetAction);
      await CommonUtil.dragLeft($, memberNameFinder);
      await CommonUtil.tapButton($, targetNameButton: 'Remove');
      await CommonUtil.tapButton($, targetNameButton: 'Remove');
      await $.pump();
    }
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedSuccess($, GroupMemberManagementTestConfig config) async {
    if (config.isAddMember) {
      await _loginUser($, config.loginPhoneForAcceptGroup, config.loginPasswordForAcceptGroup, true);
      await CommonUtil.tapNavigationBarWith($, 'Notifications');
      final groupNameFinder = find.textContaining(config.groupName);
      final rowFinder = find.ancestor(of: groupNameFinder, matching: find.byType(Row));
      final joinButtonFinder = $(rowFinder).$('Join').first;
      expect(joinButtonFinder, findsOneWidget);
      await CommonUtil.tapButton($, targetNameButton: joinButtonFinder);
      await CommonUtil.tapNavigationBarWith($, 'Menu');
      await _loginPage.proceedLogout($);
    }
    if (config.expectedLoginByOwnerPhone.isNotEmpty) {
      await _loginUser($, config.expectedLoginByOwnerPhone, config.expectedLoginByOwnerPassword, true);
    } else if (config.expectedLoginByAdminPhone.isNotEmpty) {
      await _loginUser($, config.expectedLoginByAdminPhone, config.expectedLoginByAdminPassword, true);
    } else if (config.expectedLoginByMemberPhone.isNotEmpty) {
      await _loginUser($, config.expectedLoginByMemberPhone, config.expectedLoginByMemberPassword, true);
    }
    await CommonUtil.tapNavigationBarWith($, 'Contact');
    await $.pump();
    final friendNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    final targetButtonText = 'Chat';
    final targetButtonFinder = find.text(targetButtonText);
    bool found = false;
    for (int i = 0; i < 50; i++) {
      await $.pump(const Duration(seconds: 3));
      if (find.text(targetButtonText).evaluate().isNotEmpty) {
        found = true;
        break;
      }
    }
    if (!found) {
      await $.pumpAndSettle();
    }
    await CommonUtil.tapButton($, targetNameButton: targetButtonFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: friendNameFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Member');
    await $.pump();
    List<String> members = config.expectedMemberNow.split('|');
    for (var member in members) {
      expect(find.textContaining(member), findsOne);
    }
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedFail($, GroupMemberManagementTestConfig config) async {}

  Future<void> _performCleanup($, GroupMemberManagementTestConfig config) async {
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

class GroupMemberManagementTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool? isLoginByPhone;

  // Login Details
  final String loginByAdminPhone;
  final String loginByAdminPassword;
  final String loginByOwnerPhone;
  final String loginByOwnerPassword;
  final String loginByMemberPhone;
  final String loginByMemberPassword;

  // Feature Flags & Details
  final bool isAddFriend;
  final String addFriendDetail;
  final String whoAssignToAdmin;
  final bool isCreateGroup;
  final String groupName;
  final String addMemberDetail;
  final bool isAddMember;
  final bool isRemoveMember;
  final String targetAction;
  final String loginPhoneForAcceptGroup;
  final String loginPasswordForAcceptGroup;

  // Expectations
  final String expectedLoginByAdminPhone;
  final String expectedLoginByAdminPassword;
  final String expectedLoginByOwnerPhone;
  final String expectedLoginByOwnerPassword;
  final String expectedLoginByMemberPhone;
  final String expectedLoginByMemberPassword;
  final String expectedMemberNow;
  final String expectedNavigatePage;
  final bool isExpectedSuccess;
  final String expectedMessage;

  // Registration Data Lists
  final List<String> regPhones;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  GroupMemberManagementTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        loginByAdminPhone = row['login_by_admin_phone_number'] ?? '',
        loginByAdminPassword = row['login_by_admin_password'] ?? '',
        loginByOwnerPhone = row['login_by_owner_phone_number'] ?? '',
        loginByOwnerPassword = row['login_by_owner_password'] ?? '',
        loginByMemberPhone = row['login_by_member_phone_number'] ?? '',
        loginByMemberPassword = row['login_by_member_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        whoAssignToAdmin = row['who_assign_to_admin'] ?? '',
        isCreateGroup = CommonUtil.convertStringToBoolean(row['is_create_group']),
        groupName = row['group_name'] ?? '',
        addMemberDetail = row['add_member_detail'] ?? '',
        isAddMember = CommonUtil.convertStringToBoolean(row['is_add_member']),
        isRemoveMember = CommonUtil.convertStringToBoolean(row['is_remove_member']),
        targetAction = row['target_action'] ?? '',
        loginPhoneForAcceptGroup = row['login_phone_for_accept_group'] ?? '',
        loginPasswordForAcceptGroup = row['login_password_for_accept_group'] ?? '',
        expectedLoginByOwnerPhone = row['expected_login_by_owner_phone_number'] ?? '',
        expectedLoginByOwnerPassword = row['expected_login_by_owner_password'] ?? '',
        expectedLoginByAdminPhone = row['expected_login_by_admin_phone_number'] ?? '',
        expectedLoginByAdminPassword = row['expected_login_by_admin_password'] ?? '',
        expectedLoginByMemberPhone = row['expected_login_by_member_phone_number'] ?? '',
        expectedLoginByMemberPassword = row['expected_login_by_member_password'] ?? '',
        expectedMemberNow = row['expected_member_now'] ?? '',
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
