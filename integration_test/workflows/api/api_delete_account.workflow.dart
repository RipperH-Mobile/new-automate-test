import 'package:http/http.dart' as http;
import '../../utils/api/auth_api.util.dart';
import '../../utils/api/setting_api.util.dart';
import 'package:flutter/material.dart';

class ApiDeleteAccountWorkflow {
  Future<void> deleteAccount(String phoneNumber) async {
    final client = http.Client();
    final authApi = AuthApi(client);
    final settingApi = SettingApi(client);
    try {
      // request otp
      final requestOtpBodyData = {
        'phoneOrEmail': phoneNumber,
        'isPhoneNumber': true,
      };
      final requestOtp = await authApi.requestOtp(requestOtpBodyData);
      debugPrint('\nCreated User:');
      debugPrint(requestOtp);

      // sign in
      final signInBodyData = {
        'token': requestOtp['data']['token'],
        'otp': "999999",
        'phoneOrEmail': requestOtp['data']['phoneNumber'],
        'isPhoneNumber': true,
      };
      final signIn = await authApi.signIn(signInBodyData);
      debugPrint('\nSign in:');
      debugPrint(signIn);

      // verify otp
      settingApi.setAuthToken(signIn['data']['token']);
      final verifyOtpBodyData = {
        'token': requestOtp['data']['token'],
        'otp': "999999",
        'phoneNumber': requestOtp['data']['phoneNumber'],
      };
      final verifyOtp = await settingApi.verifyOtp(verifyOtpBodyData);
      debugPrint('\nVerify otp:');
      debugPrint(verifyOtp);

      // delete account
      settingApi.setAuthToken(signIn['data']['token']);
      final deleteAccountBodyData = {
        'actionToken': verifyOtp['data']['actionToken'],
      };
      final deleteAccount = await settingApi.deleteAccount(
        deleteAccountBodyData,
      );
      debugPrint('\nDelete account:');
      debugPrint(deleteAccount);
    } catch (e) {
      debugPrint('An error occurred: $e');
    } finally {
      debugPrint('---finally---');
      client.close();
    }
  }
}
