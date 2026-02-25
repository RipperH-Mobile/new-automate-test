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

class UserSettingPinLockStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final RegisterPage _registerPage = RegisterPage();
  final AccountSettingPage _settingPage = AccountSettingPage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = UserSettingPinLockTestConfig.fromRow(dataRow);
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

  Future<void> _performRegistration($, UserSettingPinLockTestConfig config) async {
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

      // await _registerPage.proceedRegister($, _findDbUtil, sessionMap);
      // await CommonUtil.tapNavigationBarWith($, 'Menu');
      // await _loginPage.proceedLogout($);
    }
  }

  Future<void> _performAction($, UserSettingPinLockTestConfig config) async {
    if (config.isProceedSetPasscode) {
      await _settingPage.proceedPasscode($, config);
    }
  }

  Future<void> _performExpectedSuccess($, UserSettingPinLockTestConfig config) async {
    await _proceedPinLock($, config);
    await _loginPage.proceedLogout($);

    await _loginUser($, config.loginByMePhone, config.loginByMePassword, config.isLoginByPhone);
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _proceedPinLock($, config);
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedFail($, UserSettingPinLockTestConfig config) async {}

  Future<void> _performCleanup($, UserSettingPinLockTestConfig config) async {
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

  Future<void> _proceedPinLock($, config) async {
    try {
      final parentPopupMenuFinder = find.byType(Column);
      final targetTextFinder = find.descendant(of: parentPopupMenuFinder, matching: find.byType(ListTile));
      final targetProfileFinder = find.descendant(of: targetTextFinder, matching: find.byType(CircleAvatar));
      await CommonUtil.tapButton($, targetNameButton: targetProfileFinder);
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: 'PIN lock');
      await $.pump();
      await CommonUtil.tapPasscode($, targetPasscode: config.expectedPinCode);
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: 'Back');
      await $.pump();
      await CommonUtil.tapButton($, targetNameButton: find.byType(Icon));
    } catch (e, stackTrace) {
      debugPrint('---error---$e\n$stackTrace');
    }
  }
}

class UserSettingPinLockTestConfig {
  final bool isRunTestCase;
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool isLoginByPhone;
  final String loginByMePhone;
  final String loginByMePassword;

  // Passcode Settings
  final bool isProceedSetPasscode;
  final bool isSetFirstPinCode;
  final String firstPinCode;
  final String confirmFirstPinCode;
  final bool isSetNewPinCode;
  final String newPinCode;
  final String confirmNewPinCode;

  // Expectations
  final String expectedPinCode;
  final String expectedNavigatePage;
  final bool isExpectedSuccess;
  final String expectedMessage;

  // Data lists for registration
  final List<String> regPhones;
  final List<String> regEmails;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  UserSettingPinLockTestConfig.fromRow(Map<String, dynamic> row)
      : isRunTestCase = CommonUtil.convertStringToBoolean(row['is_run_test_case']),
        isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        loginByMePhone = row['login_by_me_phone_number'] ?? '',
        loginByMePassword = row['login_by_me_password'] ?? '',
        isProceedSetPasscode = CommonUtil.convertStringToBoolean(row['is_proceed_set_passcode']),
        isSetFirstPinCode = CommonUtil.convertStringToBoolean(row['is_set_first_pin_code']),
        firstPinCode = row['first_pin_code'] ?? '',
        confirmFirstPinCode = row['confirm_first_pin_code'] ?? '',
        isSetNewPinCode = CommonUtil.convertStringToBoolean(row['is_set_new_pin_code']),
        newPinCode = row['new_pin_code'] ?? '',
        confirmNewPinCode = row['confirm_new_pin_code'] ?? '',
        expectedPinCode = row['expected_pin_code'] ?? '',
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
