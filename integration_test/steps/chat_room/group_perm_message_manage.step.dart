import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/text_widgets/message_type_regular_text.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/detail_invite_member_list_item.dart';
import 'package:uchat/widgets/app_text.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/login.page.dart';
import '../../pages/register.page.dart';
import '../../pages/chat_message.page.dart';
import '../../pages/group_info.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_create_new_group.workflow.dart';
import '../../workflows/ui/ui_join_new_group.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

class GroupPermMessageManageStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiCreateNewGroupWorkflow _createNewGroupWorkflow = UiCreateNewGroupWorkflow();
  final UiJoinNewGroupWorkflow _joinNewGroupWorkflow = UiJoinNewGroupWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final RegisterPage _registerPage = RegisterPage();
  final ChatMessagePage _chatPage = ChatMessagePage();
  final GroupInfoPage _groupInfoPage = GroupInfoPage();
  late LoginPage _loginPage;
  late String currentExpectedUserProfile;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = GroupPermMessageManageTestConfig.fromRow(dataRow);
    currentExpectedUserProfile = '';
    if (config.isRunTestCase) {
      try {
        // 1. Registration Flow
        if (config.isRegister) {
          await _performRegistration($, config);
        }

        // 2. Login
        await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);

        // 3. Add Friend Flow
        if (config.isAddFriend) {
          await _performAddFriend($, config);
        }

        // 4. Create Group Flow
        if (config.isCreateGroup) {
          await _performCreateGroup($, config);
          final groupNameFinder = find.textContaining(config.groupName);
          await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
          await $.pump();
          await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
          await $.pump();
          await _groupInfoPage.proceedEnableGroupPerm($);
          await CommonUtil.tapButton($, targetNameButton: 'Back');
          await $.pump();
          await CommonUtil.tapIconBack($);
          await $.pump();
          await CommonUtil.tapNavigationBarWith($, 'Menu');
          await _loginPage.proceedLogout($);
          await _performJoinGroup($, _loginPage, config);
          if (config.whoAssignToAdmin.isNotEmpty ?? false) {
            await _performAssignAdmin($, config);
          }
        }

        // 5. Set up Group permission Workflow
        await _performAction($, config);

        // 6. Expected
        if (config.expectedLoginByOwnerPhone.isNotEmpty) {
          await _loginUser($, config.expectedLoginByOwnerPhone, config.expectedLoginByOwnerPassword, true);
          currentExpectedUserProfile = config.expectedLoginByOwnerProfile;
        } else if (config.expectedLoginByAdminPhone.isNotEmpty) {
          await _loginUser($, config.expectedLoginByAdminPhone, config.expectedLoginByAdminPassword, true);
          currentExpectedUserProfile = config.expectedLoginByAdminProfile;
        } else if (config.expectedLoginByMemberPhone.isNotEmpty) {
          await _loginUser($, config.expectedLoginByMemberPhone, config.expectedLoginByMemberPassword, true);
          currentExpectedUserProfile = config.expectedLoginByMemberProfile;
        }
        await CommonUtil.tapNavigationBarWith($, 'Chat');
        final groupNameFinder = find.textContaining(config.groupName);
        await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
        await $.pump();
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
    }
    return resultsData;
  }

  // --- Sub-routines ---

  Future<void> _performRegistration($, GroupPermMessageManageTestConfig config) async {
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
        'isLoginByPhone': true,
      };
      await _apiCreateAccountWorkflow.createAccount(currentPhone, config.getVal(config.regNames, i),
          config.getVal(config.regUchatIds, i), config.getVal(config.regPasswords, i));
    }
  }

  Future<void> _performAddFriend($, GroupPermMessageManageTestConfig config) async {
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

  Future<void> _performCreateGroup($, GroupPermMessageManageTestConfig config) async {
    await _createNewGroupWorkflow.proceedCreateGroup($, config.addMemberDetail, config.groupName);
  }

  Future<void> _performJoinGroup($, LoginPage _loginPage, GroupPermMessageManageTestConfig config) async {
    await _joinNewGroupWorkflow.proceedJoinNewGroup($, _loginPage, config);
  }

  Future<void> _performAssignAdmin($, GroupPermMessageManageTestConfig config) async {
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
    await $.pumpAndSettle();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pumpAndSettle();
    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performAction($, GroupPermMessageManageTestConfig config) async {
    await _loginUser($, config.loginByOwnerPhone, config.loginByOwnerPassword, true);
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    // Enter Group
    final groupNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
    await $.pump();
    await _groupInfoPage.proceedSetGroupPerm($, config);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedSuccess($, GroupPermMessageManageTestConfig config) async {
    final groupNameFinder = find.textContaining(config.groupName);
    await CommonUtil.tapButton($, targetNameButton: groupNameFinder);
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Member');
    await $.pump();
    final memberStatusFinder = find.ancestor(
        of: find.textContaining(currentExpectedUserProfile), matching: find.byType(DetailInviteMemberListItem));
    final targetMemberStatusFinder = $(memberStatusFinder).$(find.byType(AppText)).last;
    final userTypeFinder = find.descendant(of: targetMemberStatusFinder, matching: find.byType(Text));
    final Text userTypeText = $.tester.widget<Text>(userTypeFinder);
    final String userTypeStr = userTypeText.data ?? "";
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    await CommonUtil.tapButton($, targetNameButton: 'Back');
    await $.pump();
    if (userTypeStr != '') {
      await $(TextField).enterText(config.messageTarget);
      await CommonUtil.tapIconSendMessage($);
    }
    await $.pump();
    if (config.editMessageTarget.isNotEmpty ?? false) {
      final currentMessageFinder = $(config.messageTarget);
      await CommonUtil.tapButtonLongPressV2($, targetNameButton: currentMessageFinder);
      await CommonUtil.tapButton($, targetNameButton: 'Edit');
      await $.pump();
      await CommonUtil.tapButtonLongPressV1($, targetNameButton: currentMessageFinder);
      await $(TextField).tap();
      await $(TextField).enterText(config.editMessageTarget);
      await CommonUtil.tapIconSendMessage($);
      expect($(config.messageTarget), findsOne);
      await $.pump();
    }
    if (config.unsendMessageTarget.isNotEmpty ?? false) {
      final messageFinder = find.ancestor(
        of: find.text(config.unsendMessageTarget),
        matching: find.byType(MessageTypeRegularText),
      );
      await CommonUtil.tapButtonLongPressV2($, targetNameButton: messageFinder);
      await CommonUtil.tapButton($, targetNameButton: 'Unsend');
      await $.pump();
      final unsendFinder = find.textContaining('Unsend');
      await CommonUtil.tapButton($, targetNameButton: unsendFinder);
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: 'Unsend');
      var parsedText = $(ParsedText).first;
      ParsedText systemMessageText = $.tester.widget<ParsedText>(parsedText);
      String systemMessageTextOutput = systemMessageText.text ?? "";
      expect(systemMessageTextOutput, allOf(contains('You'), contains(config.expectedMessage)));
      await $.pump();
    }
    await CommonUtil.tapIconBack($);
    await $.pump();
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedFail($, GroupPermMessageManageTestConfig config) async {
    if (config.isNotSendMessages) {
      var parsedText = $(ParsedText).first;
      ParsedText systemMessageText = $.tester.widget<ParsedText>(parsedText);
      String systemMessageTextOutput = systemMessageText.text ?? "";
      expect(systemMessageTextOutput, contains(config.expectedMessage));
      await $.pump();
      await CommonUtil.tapIconBack($);
      await $.pump();
      await CommonUtil.tapNavigationBarWith($, 'Menu');
      await _loginPage.proceedLogout($);
    }
  }

  Future<void> _performCleanup($, GroupPermMessageManageTestConfig config) async {
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

class GroupPermMessageManageTestConfig {
  final bool isRunTestCase;
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool? isLoginByPhone;

  // Login Credentials
  final bool isLoginByAdmin;
  final String loginByAdminPhone;
  final String loginByAdminPassword;
  final String loginByOwnerPhone;
  final String loginByOwnerPassword;
  final String loginByMemberPhone;
  final String loginByMemberPassword;
  final bool isAddFriend;
  final String addFriendDetail;
  final bool isCreateGroup;
  final String groupName;
  final String addMemberDetail;
  final String whoAssignToAdmin;

  final bool isNotSendMessages;
  final bool isNotEditTheirOwnSentMessage;
  final bool isNotUnsendTheirOwnSentMessages;
  final bool isNotSendMedia;
  final bool isNotDisplayMediaTools;
  final bool isNotMentionAll;
  final bool isNotUseEmojiReactions;
  final bool isNotAddDeleteAlbumInGroup;
  final bool isSetToDefault;
  final String messageTarget;
  final String editMessageTarget;
  final String unsendMessageTarget;

  final String expectedLoginByAdminPhone;
  final String expectedLoginByAdminProfile;
  final String expectedLoginByAdminPassword;
  final String expectedLoginByOwnerPhone;
  final String expectedLoginByOwnerProfile;
  final String expectedLoginByOwnerPassword;
  final String expectedLoginByMemberPhone;
  final String expectedLoginByMemberProfile;
  final String expectedLoginByMemberPassword;
  final String expectedNavigatePage;
  final bool isExpectedSuccess;
  final String expectedMessage;

  // Registration Data Lists
  final List<String> regPhones;
  final List<String> regEmails;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  GroupPermMessageManageTestConfig.fromRow(Map<String, dynamic> row)
      : isRunTestCase = CommonUtil.convertStringToBoolean(row['is_run_test_case']),
        isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = null,
        isLoginByAdmin = CommonUtil.convertStringToBoolean(row['is_login_by_admin']),
        loginByAdminPhone = row['login_by_admin_phone_number'] ?? '',
        loginByAdminPassword = row['login_by_admin_password'] ?? '',
        loginByOwnerPhone = row['login_by_owner_phone_number'] ?? '',
        loginByOwnerPassword = row['login_by_owner_password'] ?? '',
        loginByMemberPhone = row['login_by_member_phone_number'] ?? '',
        loginByMemberPassword = row['login_by_member_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        isCreateGroup = CommonUtil.convertStringToBoolean(row['is_create_group']),
        groupName = row['group_name'] ?? 'Group Test',
        addMemberDetail = row['add_member_detail'] ?? '',
        whoAssignToAdmin = row['who_assign_to_admin'] ?? '',
        isNotSendMessages = CommonUtil.convertStringToBoolean(row['is_not_send_messages']),
        isNotEditTheirOwnSentMessage = CommonUtil.convertStringToBoolean(row['is_not_edit_their_own_sent_message']),
        isNotUnsendTheirOwnSentMessages =
            CommonUtil.convertStringToBoolean(row['is_not_unsend_their_own_sent_messages']),
        isNotSendMedia = false,
        isNotDisplayMediaTools = false,
        isNotMentionAll = false,
        isNotUseEmojiReactions = false,
        isNotAddDeleteAlbumInGroup = false,
        isSetToDefault = false,
        messageTarget = row['message_target'] ?? '',
        editMessageTarget = row['edit_message_target'] ?? '',
        unsendMessageTarget = row['unsend_message_target'] ?? '',
        expectedLoginByOwnerPhone = row['expected_login_by_owner_phone_number'] ?? '',
        expectedLoginByOwnerProfile = row['expected_login_by_owner_profile_name'] ?? '',
        expectedLoginByOwnerPassword = row['expected_login_by_owner_password'] ?? '',
        expectedLoginByAdminPhone = row['expected_login_by_admin_phone_number'] ?? '',
        expectedLoginByAdminProfile = row['expected_login_by_admin_profile_name'] ?? '',
        expectedLoginByAdminPassword = row['expected_login_by_admin_password'] ?? '',
        expectedLoginByMemberPhone = row['expected_login_by_member_phone_number'] ?? '',
        expectedLoginByMemberProfile = row['expected_login_by_member_profile_name'] ?? '',
        expectedLoginByMemberPassword = row['expected_login_by_member_password'] ?? '',
        expectedNavigatePage = row['expected_navigate_page'] ?? '',
        isExpectedSuccess = CommonUtil.convertStringToBoolean(row['expected_result']),
        expectedMessage = row['expected_message'] ?? '',
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
