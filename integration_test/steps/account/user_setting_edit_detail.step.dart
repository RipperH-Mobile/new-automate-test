import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/register.page.dart';
import '../../pages/account_setting.page.dart';
import '../../pages/login.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

class UserSettingEditDetailStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final RegisterPage _registerPage = RegisterPage();
  final AccountSettingPage _settingPage = AccountSettingPage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = UserSettingEditDetailTestConfig.fromRow(dataRow);
    if (config.isRunTestCase) {
      try {
        // 1. Registration Flow
        if (config.isRegister) {
          await _performRegistration($, config);
        }

        await _loginUser($, config.loginByMePhone, config.loginByMePassword, config.isLoginByPhone);

        // 2. Execute test
        await _performAction($, config);

        // 3. Expected
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
    }
    return resultsData;
  }

  // --- Sub-routines ---

  Future<void> _performRegistration($, UserSettingEditDetailTestConfig config) async {
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
    }
  }

  Future<void> _performAction($, UserSettingEditDetailTestConfig config) async {
    await _settingPage.proceedUserSetting($, config);
  }

  Future<void> _performExpectedSuccess($, UserSettingEditDetailTestConfig config) async {
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedFail($, UserSettingEditDetailTestConfig config) async {}

  Future<void> _performCleanup($, UserSettingEditDetailTestConfig config) async {
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
          'email': '',
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

class UserSettingEditDetailTestConfig {
  final bool isRunTestCase;
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool isLoginByPhone;
  final bool isLoginByFriend;
  final String loginByFriendPhone;
  final String loginByFriendPassword;
  final String loginByMePhone;
  final String loginByMePassword;

  // User Settings Specifics
  final bool isSelectEditProfile;
  final bool isCheckProfileName;
  final String userSettingProfileName;
  final bool isCheckUchatId;
  final String userSettingUchatId;
  final bool isCheckStatus;
  final String userSettingStatus;
  final bool isCheckDateOfBirth;
  final String userSettingDateOfBirth;

  // Expectations
  final String expectedNavigatePage;
  final bool isExpectedSuccess;
  final String expectedMessage;

  // Data lists for registration
  final List<String> regPhones;
  final List<String> regEmails;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  UserSettingEditDetailTestConfig.fromRow(Map<String, dynamic> row)
      : isRunTestCase = CommonUtil.convertStringToBoolean(row['is_run_test_case']),
        isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        isLoginByFriend = CommonUtil.convertStringToBoolean(row['is_login_by_friend']),
        loginByFriendPhone = row['login_by_friend_phone_number'] ?? '',
        loginByFriendPassword = row['login_by_friend_password'] ?? '',
        loginByMePhone = row['login_by_me_phone_number'] ?? '',
        loginByMePassword = row['login_by_me_password'] ?? '',
        isSelectEditProfile = CommonUtil.convertStringToBoolean(row['is_select_edit_profile']),
        isCheckProfileName = CommonUtil.convertStringToBoolean(row['is_check_profile_name']),
        userSettingProfileName = row['profile_name'] ?? '',
        isCheckUchatId = CommonUtil.convertStringToBoolean(row['is_check_uchat_id']),
        userSettingUchatId = row['uchat_id'] ?? '',
        isCheckStatus = CommonUtil.convertStringToBoolean(row['is_check_status']),
        userSettingStatus = row['status'] ?? '',
        isCheckDateOfBirth = CommonUtil.convertStringToBoolean(row['is_check_date_of_birth']),
        userSettingDateOfBirth = row['date_of_birth'] ?? '',
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
