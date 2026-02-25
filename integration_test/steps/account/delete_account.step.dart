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

class DeleteAccountStep {
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
    final config = DeleteAccountTestConfig.fromRow(dataRow);

    try {
      // 1. Registration Flow
      if (config.isRegister) {
        await _performRegistration($, config);
      }

      // 2. Login Main User
      await _loginUser($, config.loginByMePhone, config.loginByMePassword, config.isLoginByPhone, config.email);

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
      // Update Metadata
      await _updateResultMetadata(dataRow);
      resultsData.add(dataRow);
    }
    return resultsData;
  }

  // --- Sub-routines ---

  Future<void> _performRegistration($, DeleteAccountTestConfig config) async {
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

  Future<void> _performAction($, DeleteAccountTestConfig config) async {
    await _deleteWorkflow.proceedDeleteAccount($, config.loginByMePassword);
  }

  Future<void> _performExpectedSuccess($, DeleteAccountTestConfig config) async {
    final accountDetail = await _findDbUtil.getDetailByPhoneInAccount(
      config.loginByMePhone,
      isGetLatest: true,
    );
    expect(accountDetail, isNull);
  }

  Future<void> _performExpectedFail($, DeleteAccountTestConfig config) async {}

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

class DeleteAccountTestConfig {
  final bool isDeleteAfterRun;
  final bool isRegister;
  final bool isLoginByPhone;
  final String loginByMePhone;
  final String loginByMePassword;
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

  DeleteAccountTestConfig.fromRow(Map<String, dynamic> row)
      : isDeleteAfterRun = CommonUtil.convertStringToBoolean(row['is_delete_after_run']),
        isRegister = CommonUtil.convertStringToBoolean(row['is_register']),
        isLoginByPhone = true,
        loginByMePhone = row['login_by_me_phone_number'] ?? '',
        loginByMePassword = row['login_by_me_password'] ?? '',
        confirmNewPassword = row['confirm_password'] ?? '',
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
