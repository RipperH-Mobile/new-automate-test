import 'package:animated_flip_counter/animated_flip_counter.dart';
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

class UnreadMessageStep {
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
    final config = UnreadMessageTestConfig.fromRow(dataRow);

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

      // 4. Expected
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

  Future<void> _performRegistration($, UnreadMessageTestConfig config) async {
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

  Future<void> _performAddFriendAndChat($, UnreadMessageTestConfig config) async {
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

  Future<void> _performExpectedSuccess($, UnreadMessageTestConfig config) async {
    await _loginUser($, config.loginByFriendPhone, config.loginByFriendPassword, config.isLoginByPhone);
    await CommonUtil.tapNavigationBarWith($, 'Chat');
    final friendNameFinder = find.textContaining(config.chatTarget);
    final rowFinder = find.ancestor(of: friendNameFinder, matching: find.byType(Row));
    final animatedFlipCounterFinder = find.byType(AnimatedFlipCounter);
    final nestedFinder = $(rowFinder).$(animatedFlipCounterFinder);
    expect(nestedFinder, findsOneWidget);
    final AnimatedFlipCounter widget = $.tester.widget(nestedFinder);
    expect((widget.value).toString(), config.expectedTotalMessage);
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedFail($, UnreadMessageTestConfig config) async {}

  Future<void> _performCleanup($, UnreadMessageTestConfig config) async {
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

class UnreadMessageTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool isLoginByPhone;
  final String loginByMePhone;
  final String loginByMePassword;
  final String loginByFriendPhone;
  final String loginByFriendPassword;
  final bool isAddFriend;
  final String addFriendDetail;
  final String messageList;
  final String chatTarget;
  final String expectedTotalMessage;
  final String expectedNavigatePage;
  final bool isExpectedSuccess;
  final String expectedMessage;

  // Data lists for registration
  final List<String> regPhones;
  final List<String> regEmails;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  UnreadMessageTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        loginByMePhone = row['login_by_me_phone_number'] ?? '',
        loginByMePassword = row['login_by_me_password'] ?? '',
        loginByFriendPhone = row['login_by_friend_phone_number'] ?? '',
        loginByFriendPassword = row['login_by_friend_password'] ?? '',
        isAddFriend = CommonUtil.convertStringToBoolean(row['is_add_friend']),
        addFriendDetail = row['add_friend_detail'] ?? '',
        messageList = row['message_list'] ?? '',
        chatTarget = row['chat_target'] ?? '',
        expectedTotalMessage = row['expected_total_message'] ?? '',
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

// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter/material.dart';
// import 'package:patrol/patrol.dart';

// import '../../utils/common.util.dart';
// import '../../utils/mongodb/find_db.util.dart';
// import '../../utils/isar/find/isar-find-message.util.dart';

// import '../../pages/login.page.dart';
// import '../../pages/register.page.dart';
// import '../../pages/password_form.page.dart';
// import '../../pages/chat_message.page.dart';
// import '../../pages/account_setting.page.dart';

// import '../../steps/account/register.step.dart';
// import '../../steps/account/user_setting.step.dart';

// import '../../workflows/ui/ui_delete_account.workflow.dart';

// class UnreadMessageStep {
//   Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
//     var unreadMessageMap = Map<String, dynamic>();
//     unreadMessageMap['isDeleteAfterRun'] = CommonUtil.convertStringToBoolean(dataRow['is_delete_after_run']);
//     unreadMessageMap['isRegister'] = CommonUtil.convertStringToBoolean(dataRow['is_register']);
//     unreadMessageMap['isLoginByPhone'] = CommonUtil.convertStringToBoolean(dataRow['is_login_by_phone']);
//     unreadMessageMap['loginByMePhoneNumber'] = dataRow['login_by_me_phone_number'];
//     unreadMessageMap['loginByMePassword'] = dataRow['login_by_me_password'];
//     unreadMessageMap['isAddFriend'] = CommonUtil.convertStringToBoolean(dataRow['is_add_friend']);
//     unreadMessageMap['addFriendDetail'] = dataRow['add_friend_detail'];
//     unreadMessageMap['messageList'] = dataRow['message_list'];
//     unreadMessageMap['loginByFriendPhoneNumber'] = dataRow['login_by_friend_phone_number'];
//     unreadMessageMap['loginByFriendPassword'] = dataRow['login_by_friend_password'];
//     unreadMessageMap['chatTarget'] = dataRow['chat_target'];
//     unreadMessageMap['expectedTotalMessage'] = dataRow['expected_total_message'];
//     unreadMessageMap['expectedNavigatePage'] = dataRow['expected_navigate_page'];
//     unreadMessageMap['expectedResult'] = CommonUtil.convertStringToBoolean(dataRow['expected_result']);
//     unreadMessageMap['expectedMessage'] = dataRow['expected_message'];
//     final packageInfo = await CommonUtil.getActualCurrentAppVersion();
//     final osVersion = await CommonUtil.getActualDeviceInfo();
//     RegisterPage registerPage = new RegisterPage();
//     PasswordFormPage passwordFormPage = new PasswordFormPage();
//     LoginPage loginPage = new LoginPage();
//     ChatMessagePage chatMessagePage = new ChatMessagePage();
//     AccountSettingPage accountSettingPage = new AccountSettingPage();
//     FindDbUtil findDbUtil = new FindDbUtil();
//     IsarFindMessageUtil isarFindMessageUtil = new IsarFindMessageUtil();
//     UiDeleteAccountWorkflow uiDeleteAccountWorkflow = new UiDeleteAccountWorkflow();
//     try {
//       if (unreadMessageMap['isRegister']) {
//         // final phoneList = dataRow['register_phone_number']?.split('|') ?? [];
//         // final emailList = dataRow['register_email']?.split('|') ?? [];
//         // final nameList = dataRow['register_profile_name']?.split('|') ?? [];
//         // final passList = dataRow['register_password']?.split('|') ?? [];
//         // final confirmPassList = dataRow['register_confirm_password']?.split('|') ?? [];
//         // final uchatIdList = dataRow['register_uchat_id']?.split('|') ?? [];
//         // int dataCount = phoneList.length;
//         // for (int i = 0; i < dataCount; i++) {
//         //   Map<String, dynamic> currentSessionMap = {};
//         //   String currentPhone = _getVal(phoneList, i);
//         //   currentSessionMap['phoneWithCode'] = currentPhone;
//         //   currentSessionMap['phoneWithoutCode'] = await CommonUtil.convertE164ToNational(currentPhone);
//         //   currentSessionMap['email'] = _getVal(emailList, i);
//         //   currentSessionMap['profileName'] = _getVal(nameList, i);
//         //   currentSessionMap['password'] = _getVal(passList, i);
//         //   currentSessionMap['confirmPassword'] = _getVal(confirmPassList, i);
//         //   currentSessionMap['uchatId'] = _getVal(uchatIdList, i);
//         //   currentSessionMap['isLoginByPhone'] = unreadMessageMap['isLoginByPhone'];
//         //   currentSessionMap['expectedNavigatePage'] = unreadMessageMap['expectedNavigatePage'];
//         //   await registerPage.proceedRegister($, findDbUtil, currentSessionMap);
//         //   if (currentSessionMap['isLoginByPhone'] != true) {
//         //     await accountSettingPage.proceedAddEmail(
//         //       $,
//         //       findDbUtil,
//         //       passwordFormPage,
//         //       currentSessionMap['password'],
//         //       currentSessionMap['email'],
//         //     );
//         //   }
//         //   await CommonUtil.tapNavigationBarWith($, 'Menu');
//         //   await loginPage.proceedLogout($);
//       }
//       await loginPage.proceedLogin($, findDbUtil, unreadMessageMap);
//       if (unreadMessageMap['isAddFriend']) {
//         final List<String> dataSetList = unreadMessageMap['addFriendDetail'].split(',');
//         for (final dataSet in dataSetList) {
//           unreadMessageMap['phoneWithCode'] = dataRow['login_by_me_phone_number'];
//           unreadMessageMap['phoneWithoutCode'] = await CommonUtil.convertE164ToNational(
//             dataRow['login_by_me_phone_number'],
//           );
//           unreadMessageMap['password'] = dataRow['login_by_me_password'];
//           final List<String> fields = dataSet.trim().split('|');
//           if (fields.length < 3) continue;
//           final String inputPhoneWithCode = fields[0];
//           final String inputPassword = fields[1];
//           final String inputUchatId = fields[2];
//           final String inputPhoneNational = await CommonUtil.convertE164ToNational(inputPhoneWithCode);
//           await chatMessagePage.proceedAddFriend($, inputPhoneNational);
//           List<String> messages = unreadMessageMap['messageList'].split('|');
//           for (var message in messages) {
//             await chatMessagePage.proceedChatWithMessage($, false, inputUchatId, message);
//           }
//         }
//       }
//       await CommonUtil.tapNavigationBarWith($, 'Chat');
//       final friendNameFinder = find.textContaining(unreadMessageMap['chatTarget']);
//       final rowFinder = find.ancestor(of: friendNameFinder, matching: find.byType(Row));
//       final animatedFlipCounterFinder = find.byType(AnimatedFlipCounter);
//       final nestedFinder = $(rowFinder).$(animatedFlipCounterFinder);
//       expect(nestedFinder, findsOneWidget);
//       final AnimatedFlipCounter widget = $.tester.widget(nestedFinder);
//       expect(widget.value, unreadMessageMap['expectedTotalMessage']);
//       dataRow['actual_result'] = 'PASSED';
//     } catch (e, stackTrace) {
//       print('---error---${stackTrace}');
//       dataRow['actual_result'] = 'FAILED';
//     } finally {
//       if (unreadMessageMap['isDeleteAfterRun']) {
//         //await uiDeleteAccountWorkflow.proceedDeleteAccount($, unreadMessageMap['password']);
//       }
//       DateTime currentTime = DateTime.now();
//       dataRow['actual_version'] = 'app version ${packageInfo.version} | $osVersion | $currentTime';
//       resultsData.add(dataRow);
//     }
//     return resultsData;
//   }

//   String _getVal(List<String> list, int index) {
//     if (list.isEmpty) return "";
//     if (index >= list.length) return list.last;
//     return list[index];
//   }
// }
