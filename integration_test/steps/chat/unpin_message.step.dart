import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_regular_text.dart';
import 'package:uchat/features/chat_room/presentation/widgets/pin/latest_pin_message.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/login.page.dart';
import '../../pages/chat_message.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_create_new_group.workflow.dart';
import '../../workflows/ui/ui_join_new_group.workflow.dart';
import '../../workflows/ui/ui_chat_in_group.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

class UnpinMessageStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final UiCreateNewGroupWorkflow _createNewGroupWorkflow = UiCreateNewGroupWorkflow();
  final UiJoinNewGroupWorkflow _joinNewGroupWorkflow = UiJoinNewGroupWorkflow();
  final UiChatInGroupWorkflow _chatInGroupWorkflow = UiChatInGroupWorkflow();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final ChatMessagePage _chatPage = ChatMessagePage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = UnpinMessageTestConfig.fromRow(dataRow);

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
        await _performChatInGroup($, _loginPage, _chatPage, config);
      }

      // 5. Pin Message Flow
      if (config.isPinMessage) {
        await _performPinMessage($, config);
      }

      // 5. Unpin Message Flow
      if (config.isUnpinMessage) {
        await _performUnpinMessage($, config);
      }

      dataRow['actual_result'] = 'PASSED';
    } catch (e, stackTrace) {
      debugPrint('---error---$e\n$stackTrace');
      dataRow['actual_result'] = 'FAILED';
    } finally {
      try {
        // 6. Cleanup (Delete Account)
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

  Future<void> _performRegistration($, UnpinMessageTestConfig config) async {
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
      //await _registerPage.proceedRegister($, _findDbUtil, sessionMap);
      await _apiCreateAccountWorkflow.createAccount(currentPhone, config.getVal(config.regNames, i),
          config.getVal(config.regUchatIds, i), config.getVal(config.regPasswords, i));
    }
  }

  Future<void> _performAddFriends($, UnpinMessageTestConfig config) async {
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

  Future<void> _performCreateGroup($, UnpinMessageTestConfig config) async {
    await _createNewGroupWorkflow.proceedCreateGroup($, config.addMemberDetail, config.groupName);
  }

  Future<void> _performJoinGroup($, LoginPage _loginPage, UnpinMessageTestConfig config) async {
    await _joinNewGroupWorkflow.proceedJoinNewGroup($, _loginPage, config);
  }

  Future<void> _performChatInGroup($, LoginPage _loginPage, ChatMessagePage _chatPage, config) async {
    await _chatInGroupWorkflow.proceedChatInGroup($, _loginPage, _chatPage, config);
  }

  Future<void> _performPinMessage($, UnpinMessageTestConfig config) async {
    if (config.whoPinMessage == 'owner') {
      await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);
    } else if (config.whoPinMessage == 'admin') {
      await _loginUser($, config.loginByAdminPhone, config.loginByAdminPassword, true);
    } else {
      await _loginUser($, config.loginByMemberPhone, config.loginByMemberPassword, true);
    }
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    // Enter Group
    final groupNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
    //await $.pump();
    await $.pumpAndSettle();

    // Find Message to Pin
    final parentFinder = find.ancestor(
      of: find.text(config.pinMessageText),
      matching: find.byType(MessageTypeRegularText),
    );

    // Perform Pin Action
    await CommonUtil.tapButtonLongPressV2($, targetNameButton: parentFinder);
    await CommonUtil.tapButton($, targetNameButton: 'Pin');
    await $.pump(const Duration(seconds: 1));

    final latestPinMessageFinder = find.ancestor(
      of: find.textContaining('Pinned messages'),
      matching: find.byType(LatestPinMessage),
    );
    final pinMessageText = $(latestPinMessageFinder).$(find.text(config.pinMessageText));
    expect(pinMessageText, findsWidgets);

    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performUnpinMessage($, UnpinMessageTestConfig config) async {
    if (config.whoUnpinMessage == 'owner') {
      await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);
    } else if (config.whoUnpinMessage == 'admin') {
      await _loginUser($, config.loginByAdminPhone, config.loginByAdminPassword, true);
    } else {
      await _loginUser($, config.loginByMemberPhone, config.loginByMemberPassword, true);
    }
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    // Enter Group
    final groupNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
    await $.pump();

    // Find Message to Unpin
    final parentFinder = find.ancestor(
      of: find.text(config.pinMessageText),
      matching: find.byType(MessageTypeRegularText),
    );

    // Perform Unpin Action
    await CommonUtil.tapButtonLongPressV2($, targetNameButton: parentFinder);
    await CommonUtil.tapButton($, targetNameButton: 'Unpin');
    await $.pump(const Duration(seconds: 1));
    final latestPinMessageFinder = find.ancestor(
      of: find.textContaining('Pinned messages'),
      matching: find.byType(LatestPinMessage),
    );
    final pinMessageText = $(latestPinMessageFinder).$(find.text(config.pinMessageText));
    expect(pinMessageText, findsNothing);

    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performCleanup($, UnpinMessageTestConfig config) async {
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

class UnpinMessageTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool? isLoginByPhone;

  // Login Details
  final bool isLoginByAdmin;
  final String loginByAdminPhone;
  final String loginByAdminPassword;
  final bool isLoginByOwner;
  final String loginByOwnerPhone;
  final String loginByOwnerPassword;
  final bool isLoginByMember;
  final String loginByMemberPhone;
  final String loginByMemberPassword;

  // Feature Flags & Details
  final bool isAddFriend;
  final String addFriendDetail;
  final bool isCreateGroup;
  final String groupName;
  final String addMemberDetail;
  final String adminMessageList;
  final String ownerMessageList;
  final String memberMessageList;
  final bool isPinMessage;
  final String whoPinMessage;
  final String pinMessageText;
  final bool isUnpinMessage;
  final String whoUnpinMessage;
  final String unpinMessageText;

  // Expectations
  final String expectedNavigatePage;
  final bool expectedResult;
  final String expectedMessage;

  // Registration Data Lists
  final List<String> regPhones;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  UnpinMessageTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = null,
        isLoginByAdmin = CommonUtil.convertStringToBoolean(row['is_login_by_admin']),
        loginByAdminPhone = row['login_by_admin_phone_number'] ?? '',
        loginByAdminPassword = row['login_by_admin_password'] ?? '',
        isLoginByOwner = CommonUtil.convertStringToBoolean(row['is_login_by_owner']),
        loginByOwnerPhone = row['login_by_owner_phone_number'] ?? '',
        loginByOwnerPassword = row['login_by_owner_password'] ?? '',
        isLoginByMember = CommonUtil.convertStringToBoolean(row['is_login_by_member']),
        loginByMemberPhone = row['login_by_member_phone_number'] ?? '',
        loginByMemberPassword = row['login_by_member_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        isCreateGroup = CommonUtil.convertStringToBoolean(row['is_create_group']),
        groupName = row['group_name'] ?? 'Group Test',
        addMemberDetail = row['add_member_detail'] ?? '',
        adminMessageList = row['admin_message_list'] ?? '',
        ownerMessageList = row['owner_message_list'] ?? '',
        memberMessageList = row['member_message_list'] ?? '',
        isPinMessage = CommonUtil.convertStringToBoolean(row['is_pin_message']),
        whoPinMessage = row['who_pin_message'] ?? '',
        pinMessageText = row['pin_message'] ?? '',
        isUnpinMessage = CommonUtil.convertStringToBoolean(row['is_unpin_message']),
        whoUnpinMessage = row['who_unpin_message'] ?? '',
        unpinMessageText = row['unpin_message'] ?? '',
        expectedNavigatePage = row['expected_navigate_page'] ?? '',
        expectedResult = CommonUtil.convertStringToBoolean(row['expected_result']),
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
