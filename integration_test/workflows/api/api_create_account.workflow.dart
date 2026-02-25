import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/features/auth/data/models/requests/auth_register_request.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';
import 'package:uchat/features/auth/data/models/requests/check_user_exist_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import '../../utils/mongodb/find_db.util.dart';
import '../../utils/mongodb/update_db.util.dart';

class ApiCreateAccountWorkflow {
  Future<void> createAccount(
    String phone,
    String displayName,
    String username,
    String password, {
    String? email,
    File? profileImage,
  }) async {
    final HttpCaller myHttpCaller = HttpCaller();
    final AuthApiServiceNew authService = AuthApiServiceNew(httpCaller: myHttpCaller);
    final FindDbUtil _findDbUtil = FindDbUtil();
    final UpdateDbUtil _updateDbUtil = UpdateDbUtil();

    debugPrint('🏁 Start Create Account Workflow for: $phone');

    try {
      // ---------------------------------------------------------
      // STEP 1: Check User Phone/Email
      // ---------------------------------------------------------
      debugPrint('📍 [Step 1] Requesting OTP...');

      final checkUserExistRequest = CheckUserExistRequest(
        phoneOrEmail: phone,
        isSignUp: true,
      );

      final requestOTPResponseMap = await authService.checkUserExist(checkUserExistRequest);
      debugPrint('   CreateAccount > RequestOTP Response: ${requestOTPResponseMap}');

      // Validation Step 1
      if ((requestOTPResponseMap?['token'] ?? '').toString().isEmpty) {
        debugPrint('❌ [Step 1 Failed] Request OTP failed or invalid response.');
        return;
      }

      final String token = requestOTPResponseMap?['token'];
      debugPrint('✅ [Step 1 Success] Token received: $token');

      // ---------------------------------------------------------
      // STEP 2: Get OTP from DB (For Test/Dev)
      // ---------------------------------------------------------
      debugPrint('📍 [Step 2] Fetching OTP from DB...');

      var otpNo = '999999';
      if (requestOTPResponseMap?['ref'] != 'GOD MODE') {
        otpNo = await _findDbUtil.getOtpByPhone(phone, isGetLatest: true);
        debugPrint('   CreateAccount > OTP found in DB: $otpNo');
      } else {
        debugPrint('   CreateAccount > God Mode detected, using default OTP.');
      }

      if (otpNo.isEmpty) {
        debugPrint('❌ [Step 2 Failed] OTP not found in Database.');
        return;
      }
      debugPrint('✅ [Step 2 Success] Using OTP: $otpNo');

      // ---------------------------------------------------------
      // STEP 3: Verify OTP
      // ---------------------------------------------------------
      debugPrint('📍 [Step 3] Verifying OTP...');

      final verifyOTPRequest = VerifyOTPRequest(
        token: token,
        otp: otpNo,
        phoneOrEmail: phone,
        actionName: AuthenticationActionType.signup,
      );

      final verifyOtpResponse = await authService.verifyOTP(verifyOTPRequest);
      debugPrint('   CreateAccount > VerifyOTP Response: ${verifyOtpResponse?.toJson()}');

      // Validation Step 3
      final String actionToken = verifyOtpResponse?.actionToken ?? '';
      if (actionToken.isEmpty) {
        debugPrint('❌ [Step 3 Failed] Verify OTP failed. No actionToken received.');
        return;
      }
      debugPrint('✅ [Step 3 Success] Action Token: $actionToken');

      // ---------------------------------------------------------
      // STEP 4: Register (Create User)
      // ---------------------------------------------------------
      debugPrint('📍 [Step 4] Registering User...');

      final authRegisterRequest = AuthRegisterRequest(
        actionToken: actionToken,
        displayName: displayName,
        username: username,
        password: password,
        phoneNumber: phone,
        avatarPhotoFile: profileImage,
      );

      final authLoginResponse = await authService.register(authRegisterRequest);
      debugPrint('   CreateAccount > Register Response: ${authLoginResponse}');

      // Validation Step 4
      if (authLoginResponse != null) {
        debugPrint('🎉 [SUCCESS] User Created Successfully: $username');
        await _updateDbUtil.updateGroupPermissionInAccount(phone);
      } else {
        debugPrint('❌ [Step 4 Failed] Register returned null response.');
      }
    } catch (e, stackTrace) {
      debugPrint('💥 Exception in createAccount Workflow: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }
}
