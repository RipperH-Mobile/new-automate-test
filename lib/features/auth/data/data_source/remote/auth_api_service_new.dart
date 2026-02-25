import 'package:dio/dio.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/features/auth/data/models/requests/auth_code_verify_token_request.dart';
import 'package:uchat/features/auth/data/models/requests/check_user_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/delete_session_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_method_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_two_fa_login_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_sessions_list_request.dart';
import 'package:uchat/features/auth/data/models/requests/link_email_otp_request.dart';
import 'package:uchat/features/auth/data/models/requests/link_email_verify_otp_request.dart';
import 'package:uchat/features/auth/data/models/requests/multifactor_update_setting_request.dart';
import 'package:uchat/features/auth/data/models/requests/multifactor_validate_setting_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_email_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_email_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_password_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_token_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/responses/auth_login_response.dart';
import 'package:uchat/features/auth/data/models/responses/check_password_required_response.dart';
import 'package:uchat/features/auth/data/models/responses/check_password_response.dart';
import 'package:uchat/features/auth/data/models/responses/check_user_forgot_password_response.dart';
import 'package:uchat/features/auth/data/models/responses/get_otp_method_forgot_password_response.dart';
import 'package:uchat/features/auth/data/models/responses/get_sessions_list_response.dart';
import 'package:uchat/features/auth/data/models/responses/multifactor_validate_response.dart';
import 'package:uchat/features/auth/data/models/responses/otp_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_otp_login_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_otp_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_password_setting_account_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_token_forgot_password_response.dart';

import '../../models/responses/auth_code_verify_response.dart';

class AuthApiServiceNew {
  final HttpCaller httpCaller;

  AuthApiServiceNew({
    required this.httpCaller,
  });

  Future<AuthLoginResponse?> register(AuthRegisterRequest request) async {
    final data = await request.toFormData();

    final httpResp = await httpCaller.post(
      BackendPath.register.http,
      options: Options(headers: {
        'content-type': 'multipart/form-data',
      }),
      data: data,
    );

    return httpResp.mapToResponse((data) => AuthLoginResponse.fromMap(data));
  }

  Future<VerifyOtpResponse?> verifyOTP(VerifyOTPRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.verifyOtpForgotPassword.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3<VerifyOtpResponse>(
      (data) => VerifyOtpResponse.fromMap(data),
    );
  }

  Future<void> verifyUChatID(String userId) async {
    await httpCaller.post(
      BackendPath.verifyUChatId.http,
      data: {'username': userId},
    );
  }

  // If access token is null, it will use the current user's access token.
  // Otherwise, it will use the provided access token to logout.
  Future<void> logout({String? accessToken}) async {
    await httpCaller.post(
      BackendPath.logout.http,
      customAccessToken: accessToken,
    );
  }

  Future<VerifyDebugPasscodeResponse?> verifyDebugPasscode(
    VerifyDebugPasscodeRequest request,
  ) async {
    final httpResp = await httpCaller.post(
      BackendPath.verifyDebugPasscode.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<VerifyDebugPasscodeResponse>(
      (data) => VerifyDebugPasscodeResponse.fromMap(data),
    );
  }

  Future<Map<String, dynamic>?> checkUserExist(CheckUserExistRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.authUserCheck.http,
      data: request.toMap(),
    );
    return httpResp.mapToResponseV3(
      (data) => data,
    );
  }

  Future<CheckPasswordResponse?> checkPassword(CheckUserExistWithPasswordRequest request) async {
    final res = await httpCaller.post(
      BackendPath.authUserCheck.http,
      data: request.toMap(),
    );

    final map = res.mapToResponseV3(
      (data) => data,
    );
    if (map == null) {
      return null;
    }

    if (map['token'] != null) {
      return res.mapToResponseV3((data) => CheckPasswordResponseUnableTwoFa.fromJson(data));
    } else {
      return res.mapToResponseV3((data) => CheckPasswordResponseEnableTwoFa.fromJson(data));
    }
  }

  Future<VerifyOtpLoginResponse?> signIn(AuthSignInRequest request) async {
    final response = await httpCaller.post(
      BackendPath.signIn.http,
      data: request.toMap(),
    );

    return response.mapToResponse<VerifyOtpLoginResponse>(
      (data) => VerifyOtpLoginResponse.fromJson(data),
    );
  }

  Future<bool> officialAccountQRSignInVerifyToken(OAQRVerifyTokenRequest request) async {
    final resp = await httpCaller.post(
      BackendPath.officialAccountQRSignInVerifyToken.http,
      data: request.toMap(),
    );
    return resp.data;
  }

  Future<AuthCodeVerifyResponse?> authCodeVerifyToken(AuthCodeVerifyTokenRequest request) async {
    final resp = await httpCaller.post(
      BackendPath.authCodeVerifyToken.http,
      data: request.toMap(),
    );

    return resp.mapToResponseV3((data) => AuthCodeVerifyResponse.fromMap(data));
  }

  Future<void> deleteAccount(DeleteAccountRequest request) async {
    await httpCaller.delete(
      BackendPath.deleteAccount.http,
      data: request.toMap(),
    );
  }

  Future<OtpResponse?> linkAccountWithEmail(LinkEmailOtpRequest request) async {
    // Fallback to http caller
    final httpResp = await httpCaller.post(
      BackendPath.updateEmailOtpRequest.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse((data) => OtpResponse.fromJson(data));
  }

  Future<UserCollection?> linkEmailVerifyOtp(LinkEmailVerifyOtpRequest request) async {
    // Fallback to http caller
    final httpResp = await httpCaller.put(
      BackendPath.updateEmail.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  Future<bool?> setPassword(ChangePasswordRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.changePassword.http,
      data: request.toMap(),
    );

    return httpResp.data;
  }

  Future<CheckUserForgotPasswordResponse?> checkUserForgotPassword(CheckUserForgotPasswordRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.authUserCheck.http,
      data: request.toMap(),
    );
    return httpResp.mapToResponseV3((data) => CheckUserForgotPasswordResponse.fromJson(data));
  }

  Future<OtpResponse?> getOtpForgotPassword(GetOtpForgotPasswordRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.getOtpForgotPassword.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponseV3<OtpResponse>(
      (data) => OtpResponse.fromJson(data),
    );
  }

  Future<OtpResponse?> getOtpTwoFaLogin(GetOtpTwoFaLoginRequest request) async {
    // There is no socket for this action, because preventing about 'exclusive-token'
    // Socket cannot sent it anyway

    final httpResp = await httpCaller.post(
      BackendPath.authSelectOtpType.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse<OtpResponse>(
      (data) => OtpResponse.fromJson(data),
    );
  }

  Future<OtpResponse?> getOtpSettingAccount(GetOtpSettingAccountRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.getOtpTwoFa.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponseV3<OtpResponse>(
      (data) => OtpResponse.fromJson(data),
    );
  }

  Future<VerifyOtpResponse?> verifyOtpTwoFa(VerifyOtpSettingAccountRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.verifyOtpTwoFa.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponseV3<VerifyOtpResponse>(
      (data) => VerifyOtpResponse.fromMap(data),
    );
  }

  Future<CheckPasswordRequiredResponse?> checkPasswordRequired() async {
    final httpResp = await httpCaller.get(
      BackendPath.accountSettingCheckPasswordRequire.http,
    );
    return httpResp.mapToResponseV3((data) => CheckPasswordRequiredResponse.fromJson(data));
  }

  Future<VerifyPasswordSettingAccountResponse?> verifyPasswordSettingAccount(
      VerifyPasswordSettingAccountRequest request) async {
    final res = await httpCaller.post(
      BackendPath.accountSettingVerifyPassword.http,
      data: request.toJson(),
    );

    final map = res.mapToResponseV3(
      (data) => data,
    );
    if (map == null) {
      return null;
    }

    if (map['actionToken'] != null) {
      return res.mapToResponseV3((data) => VerifyPasswordSettingAccountUnable2faResponse.fromJson(data));
    } else {
      return res.mapToResponseV3((data) => VerifyPasswordSettingAccountEnable2faResponse.fromJson(data));
    }
  }

  Future<void> validateNewEmailSettingAccount(ValidateNewEmailSettingAccountRequest request) async {
    await httpCaller.get(
      BackendPath.accountSettingValidateNewEmail.http,
      queryParameters: request.toJson(),
    );
  }

  Future<void> updateEmailSettingAccount(UpdateEmailSettingAccountRequest request) async {
    await httpCaller.post(
      BackendPath.accountSettingUpdateEmail.http,
      data: request.toJson(),
    );
  }

  Future<void> validateNewPassword(ValidateNewPasswordRequest request) async {
    await httpCaller.get(
      BackendPath.settingNewPasswordValidate.http,
      queryParameters: request.toJson(),
    );
  }

  Future<void> updateNewPassword(UpdateNewPasswordRequest request) async {
    await httpCaller.post(
      BackendPath.settingUpdateNewPassword.http,
      data: request.toJson(),
    );
  }

  Future<MultifactorValidateResponse?> multifactorValidate(
    MultifactorValidateSettingRequest request,
  ) async {
    final res = await httpCaller.get(
      BackendPath.settingMultifactorValidate.http,
      queryParameters: request.toJson(),
    );

    final map = res.mapToResponseV3(
      (data) => data,
    );
    if (map == null) {
      return null;
    }

    if (map['isGetOtp'] != null) {
      return res.mapToResponseV3((data) => MultifactorValidateTurnOffResponse.fromJson(data));
    } else {
      return res.mapToResponseV3((data) => MultifactorValidateTurnOnResponse.fromJson(data));
    }
  }

  Future<void> multifactorUpdate(MultifactorUpdateSettingRequest request) async {
    await httpCaller.post(
      BackendPath.settingMultifactorUpdate.http,
      data: request.toJson(),
    );
  }

  Future<PaginationPayload<GetSessionsListResponse>?> getSessionsListResponse(
    GetSessionsListRequest request,
  ) async {
    final httpResp = await httpCaller.post(
      BackendPath.getSessionsList.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse((e) {
      return PaginationPayload<GetSessionsListResponse>.fromMapV3(
        e,
        listMapper: (data) {
          List<GetSessionsListResponse> dataList = [];
          for (final item in data) {
            dataList.add(GetSessionsListResponse.fromMap(
              item,
            ));
          }
          return dataList;
        },
      );
    });
  }

  Future<void> deleteSession(DeleteSessionRequest request) async {
    await httpCaller.delete(
      BackendPath.deleteSession.http,
      data: request.toMap(),
    );
  }

  Future<void> deleteSessionsList(String request) async {
    await httpCaller.delete(
      BackendPath.deleteSessionsList.http,
      data: {
        'actionToken': request,
      },
    );
  }

  Future<GetOtpMethodForgotPasswordResponse?> getOtpMethodForgotPassword(
      GetOtpMethodForgotPasswordRequest request) async {
    final response = await httpCaller.post(
      BackendPath.getOtpMethodForgotPassword.http,
      data: request.toJson(),
    );

    return response.mapToResponseV3((data) => GetOtpMethodForgotPasswordResponse.fromJson(data));
  }

  Future<VerifyTokenForgotPasswordResponse?> verifyTokenForgotPassword(VerifyTokenForgotPasswordRequest request) async {
    final response = await httpCaller.post(
      BackendPath.verifyTokenForgotPassword.http,
      data: request.toJson(),
    );

    return response.mapToResponseV3((data) => VerifyTokenForgotPasswordResponse.fromJson(data));
  }

  Future<void> validateForgotPassword(ValidateForgotPasswordRequest request) async {
    await httpCaller.post(
      BackendPath.validateForgotPassword.http,
      data: request.toJson(),
    );
  }
}
