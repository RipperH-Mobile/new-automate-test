import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../../utils/common.util.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

import '../../pages/login.page.dart';
import '../../pages/register.page.dart';
import '../../pages/password_form.page.dart';
import '../../pages/account_setting.page.dart';

import '../../workflows/api/api_create_account.workflow.dart';
import '../../workflows/ui/ui_delete_account.workflow.dart';

class ForgetPasswordStep {
  final FindDbUtil _findDbUtil = FindDbUtil();
  final UpdateDbUtil _updateDbUtil = UpdateDbUtil();
  final ApiCreateAccountWorkflow _apiCreateAccountWorkflow = ApiCreateAccountWorkflow();
  final UiDeleteAccountWorkflow _deleteWorkflow = UiDeleteAccountWorkflow();
  final RegisterPage _registerPage = RegisterPage();
  final PasswordFormPage _passwordPage = PasswordFormPage();
  final AccountSettingPage _settingPage = AccountSettingPage();
  late LoginPage _loginPage;

  Future<List<Map<String, dynamic>>> proceedTest($, dataRow, resultsData) async {
    _loginPage = LoginPage($, _findDbUtil);
    final config = ForgetPasswordTestConfig.fromRow(dataRow);

    try {
      // 1. Registration Flow
      if (config.isRegister) {
        await _performRegistration($, config);
      }

      // 2. Login Main User
      await _loginUser(
          $, config.loginByMePhone, config.loginByMePassword, config.isLoginByPhone, config.loginByMeEmail);

      // 3. Execute test
      await _performAction($, config);

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

  Future<void> _performRegistration($, ForgetPasswordTestConfig config) async {
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

  Future<void> _performAction($, ForgetPasswordTestConfig config) async {
    if (Platform.isIOS) {
      for (int i = 0; i < 8; i++) {
        await CommonUtil.tapNavigationBarWith($, 'Contact');
        await CommonUtil.tapNavigationBarWith($, 'Chat');
        await CommonUtil.tapNavigationBarWith($, 'Call');
        await CommonUtil.tapNavigationBarWith($, 'Notifications');
      }
    } else {
      await CommonUtil.tapNavigationBarWith($, 'Contact');
      await CommonUtil.tapNavigationBarWith($, 'Chat');
      await CommonUtil.tapNavigationBarWith($, 'Call');
      await CommonUtil.tapNavigationBarWith($, 'Notifications');
    }
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
    config.phoneWithoutCode = await CommonUtil.convertE164ToNational(config.phoneWithCode);
    config.email = config.loginByMeEmail;
    config.password = config.loginByMePassword;
    await _loginPage.proceedForgetPassword(
      $,
      _passwordPage,
      config,
    );
  }

  Future<void> _performExpectedSuccess($, ForgetPasswordTestConfig config) async {
    await _loginUser($, config.loginByMePhone, config.newPassword, config.isLoginByPhone, config.loginByMeEmail);
    await CommonUtil.tapNavigationBarWith($, 'Menu');
    await _loginPage.proceedLogout($);
  }

  Future<void> _performExpectedFail($, ForgetPasswordTestConfig config) async {}

  Future<void> _performCleanup($, ForgetPasswordTestConfig config) async {
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
    //   final password = config.getVal(config.regPasswords, i);
    //   final email = config.getVal(config.regEmails, i);

    //   if (currentPhone.isEmpty) continue;

    //   // Ensure logged in before delete
    //   await _loginUser($, currentPhone, password, true, email);
    //   await _deleteWorkflow.proceedDeleteAccount($, password);
    // }
  }

  Future<void> _loginUser($, String phoneWithCode, String password, bool isPhoneLogin, String email) async {
    await _loginPage.proceedLogin(
        isPhoneLogin: isPhoneLogin,
        phoneWithoutCode: await CommonUtil.convertE164ToNational(phoneWithCode),
        phoneWithCode: await CommonUtil.convertE164ToNational(phoneWithCode),
        password: password,
        email: email);
  }

  Future<void> _updateResultMetadata(Map<String, dynamic> dataRow) async {
    final packageInfo = await CommonUtil.getActualCurrentAppVersion();
    final osVersion = await CommonUtil.getActualDeviceInfo();
    dataRow['actual_version'] = 'app version ${packageInfo.version} | $osVersion | ${DateTime.now()}';
  }
}

class ForgetPasswordTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool isLoginByPhone;
  final String loginByMePhone;
  final String loginByMePassword;
  final String loginByMeEmail;
  final String newPassword;
  final String confirmNewPassword;
  final String expectedMessage;
  final String expectedNavigatePage;
  final bool isExpectedSuccess;

  String phoneWithCode;
  String phoneWithoutCode;
  String email;
  String password;

  // Data lists for registration
  final List<String> regPhones;
  final List<String> regEmails;
  final List<String> regNames;
  final List<String> regPasswords;
  final List<String> regUchatIds;

  ForgetPasswordTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = CommonUtil.convertStringToBoolean(row['is_login_by_phone']),
        loginByMePhone = row['login_by_me_phone_number'] ?? '',
        loginByMeEmail = row['login_by_me_email'] ?? '',
        loginByMePassword = row['login_by_me_password'] ?? '',
        newPassword = row['new_password'] ?? '',
        confirmNewPassword = row['confirm_new_password'] ?? '',
        phoneWithCode = row['login_by_me_phone_number'] ?? '',
        phoneWithoutCode = '',
        email = '',
        password = '',
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
