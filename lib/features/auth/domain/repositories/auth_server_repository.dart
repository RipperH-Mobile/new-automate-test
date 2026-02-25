import 'dart:io';

import 'package:recaptcha_enterprise_flutter/recaptcha_action.dart';
import 'package:recaptcha_enterprise_flutter/recaptcha_client.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/payloads/qr_code_login/update_qr_code_login_request.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
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
import 'package:uchat/features/auth/data/models/requests/save_otp_response_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_email_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_linking_account_with_social_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_email_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_password_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_token_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/responses/get_otp_method_forgot_password_response.dart';
import 'package:uchat/features/auth/data/models/responses/get_sessions_list_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_token_forgot_password_response.dart';
import 'package:uchat/features/auth/domain/entities/auth_login_entity.dart';
import 'package:uchat/features/auth/domain/entities/check_password_entity.dart';
import 'package:uchat/features/auth/domain/entities/check_password_required_entity.dart';
import 'package:uchat/features/auth/domain/entities/check_user_entity.dart';
import 'package:uchat/features/auth/domain/entities/check_user_forgot_password_entity.dart';
import 'package:uchat/features/auth/domain/entities/get_term_and_condition_from_server_params.dart';
import 'package:uchat/features/auth/domain/entities/multifactor_validate_entity.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/entities/social_link_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_login_entity.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';

import '../../data/models/requests/auth_code_verify_token_request.dart';
import '../entities/auth_code_verify_entity.dart';

abstract class AuthServerRepository {
  Future<CheckUserEntity> checkUserExist(CheckUserExistRequest request);

  Future<CheckPasswordEntity> checkPassword(CheckUserExistWithPasswordRequest request);

  Future<void> deleteAccount(DeleteAccountRequest request);

  Future<File> getTermAndConditionFromServer(GetTermAndConditionFromServerParams request);

  Future<bool> postQrCodeLogin(UpdateQrCodeLoginRequest request);

  Future<bool> forgotPassword(ForgotPasswordRequest request);

  Future<bool> officialAccountQRSignInVerifyToken(OAQRVerifyTokenRequest request);

  Future<AuthCodeVerifyEntity?> authCodeVerifyToken(AuthCodeVerifyTokenRequest request);

  Future<VerifyOtpLoginEntity> verifyOtpLogin(AuthSignInRequest request);

  Future<VerifyOtpEntity> verifyOtp(VerifyOTPRequest request);

  Future<RecaptchaClient> reCaptchaFetchClient(String key);

  Future<String> reCaptchaExecute(RecaptchaAction action);

  Future<void> verifyUChatID(String request);

  Future<AuthLoginEntity> register(AuthRegisterRequest request);

  Future<OtpEntity> linkAccountWithEmail(LinkEmailOtpRequest request);

  Future<UserEntity> verifyOtpLinkEmail(LinkEmailVerifyOtpRequest request);

  Future<void> setPassword(ChangePasswordRequest request);

  Future<void> saveOtpResponse(SaveOtpResponseRequest request);

  Future<OtpEntity> getOtpResponse(String phoneOrEmail);

  Future<void> clearOtpResponse(String phoneOrEmail);

  Future<CheckUserForgotPasswordEntity> checkUserForgotPassword(CheckUserForgotPasswordRequest request);

  Future<OtpEntity> getOtpForgotPassword(GetOtpForgotPasswordRequest request);

  Future<UserResponse?> updateAccountSetting(UpdateAccountSettingRequest param);

  Future<OtpEntity> getOtpSettingAccount(GetOtpSettingAccountRequest request);

  Future<VerifyOtpEntity> verifyOtpTwoFa(VerifyOtpSettingAccountRequest request);

  Future<CheckPasswordRequiredEntity> checkPasswordRequired();

  Future<VerifyPasswordSettingAccountEntity> verifyPasswordSettingAccount(VerifyPasswordSettingAccountRequest request);

  Future<void> validateNewEmailSettingAccount(ValidateNewEmailSettingAccountRequest request);

  Future<void> updateEmailSettingAccount(UpdateEmailSettingAccountRequest request);

  Future<void> validateNewPassword(ValidateNewPasswordRequest request);

  Future<void> updateNewPassword(UpdateNewPasswordRequest request);

  Future<MultifactorValidateEntity> multifactorValidate(
    MultifactorValidateSettingRequest request,
  );

  Future<void> multifactorUpdate(MultifactorUpdateSettingRequest request);

  Future<PaginationPayload<GetSessionsListResponse>?> getSessionsList(GetSessionsListRequest request);

  Future<void> deleteSession(DeleteSessionRequest request);

  Future<void> deleteSessionsList(String request);

  Future<SocialLinkEntity> settingAccountLinkAccountWithGoogle(UpdateLinkingAccountWithSocialRequest params);

  Future<SocialLinkEntity> settingAccountUnlinkAccountWithGoogle(String actionToken);

  Future<SocialLinkEntity> settingAccountLinkAccountWithApple(UpdateLinkingAccountWithSocialRequest params);

  Future<SocialLinkEntity> settingAccountUnlinkAccountWithApple(String actionTokens);

  Future<SocialLinkEntity> settingAccountLinkAccountWithFacebook(UpdateLinkingAccountWithSocialRequest params);

  Future<SocialLinkEntity> settingAccountUnlinkAccountWithFacebook(String actionTokens);

  Future<GetOtpMethodForgotPasswordResponse> getOtpMethodForgotPassword(GetOtpMethodForgotPasswordRequest request);

  Future<VerifyTokenForgotPasswordResponse> verifyTokenForgotPassword(VerifyTokenForgotPasswordRequest request);

  Future<void> validateForgotPassword(ValidateForgotPasswordRequest request);

  Future<OtpEntity> getOtpTwoFaLogin(GetOtpTwoFaLoginRequest request);
}
