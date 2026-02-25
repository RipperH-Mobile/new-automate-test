import 'dart:io';

import 'package:recaptcha_enterprise_flutter/recaptcha.dart';
import 'package:recaptcha_enterprise_flutter/recaptcha_action.dart';
import 'package:recaptcha_enterprise_flutter/recaptcha_client.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/payloads/qr_code_login/update_qr_code_login_request.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/extensions/api_exception_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_socket_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/qr_code_login_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/social_auth_api_service.dart';
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
import 'package:uchat/features/auth/data/models/responses/check_password_response.dart';
import 'package:uchat/features/auth/data/models/responses/check_user_response.dart';
import 'package:uchat/features/auth/data/models/responses/get_otp_method_forgot_password_response.dart';
import 'package:uchat/features/auth/data/models/responses/get_sessions_list_response.dart';
import 'package:uchat/features/auth/data/models/responses/multifactor_validate_response.dart';
import 'package:uchat/features/auth/data/models/responses/otp_response.dart';
import 'package:uchat/features/auth/data/models/responses/verify_password_setting_account_response.dart';
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
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';

import '../../domain/entities/auth_code_verify_entity.dart';

class AuthServerRepositoryImpl implements AuthServerRepository {
  final SocketCaller socketCaller;
  final AuthSocketService authSocketService;
  final AuthApiServiceNew authApiServiceNew;
  final AccountService accountService;
  final QrCodeLoginService qrCodeLoginService;
  final ConfigInstance configGeneral;
  final SocialAuthApiService socialAuthApiService;

  AuthServerRepositoryImpl({
    required this.socketCaller,
    required this.authSocketService,
    required this.authApiServiceNew,
    required this.accountService,
    required this.qrCodeLoginService,
    required this.configGeneral,
    required this.socialAuthApiService,
  });

  final _log = useLogger();

  CheckPasswordEntity _handleCheckPasswordResponse(CheckPasswordResponse? response) {
    if (response == null) {
      throw NullResponseException();
    }
    if (response is CheckPasswordResponseUnableTwoFa) {
      return response.toEntity();
    } else if (response is CheckPasswordResponseEnableTwoFa) {
      return response.toEntity();
    }
    // This line should ideally not be reached if the response types are exhaustive
    // and one of the conditions above is met.
    // Consider if there's a default or error entity to return,
    // or if this indicates an unhandled response type.
    throw Exception('Unknown CheckPasswordResponse type');
  }

  @override
  Future<CheckPasswordEntity> checkPassword(CheckUserExistWithPasswordRequest request) async {
    final httpResp = await authApiServiceNew.checkPassword(request);
    if (httpResp == null) {
      throw NullResponseException();
    }
    return _handleCheckPasswordResponse(httpResp);
  }

  @override
  Future<File> getTermAndConditionFromServer(GetTermAndConditionFromServerParams request) {
    // TODO: implement getTermAndConditionFromServer
    throw UnimplementedError();
  }

  @override
  Future<CheckUserEntity> checkUserExist(CheckUserExistRequest request) async {
    final httpResp = await authApiServiceNew.checkUserExist(request);
    if (httpResp != null) {
      if (httpResp['passwordRequired'] == true) {
        return CheckUserPasswordResponse.fromJson(httpResp).toEntity();
      } else {
        return CheckUserOtpResponse.fromJson(httpResp).toEntity();
      }
    } else {
      throw NullResponseException();
    }
  }

  @override
  Future<VerifyOtpLoginEntity> verifyOtpLogin(AuthSignInRequest request) async {
    final httpResp = await authApiServiceNew.signIn(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    } else {
      throw NullResponseException();
    }
  }

  @override
  Future<String> reCaptchaExecute(RecaptchaAction action) async {
    String result = await RecaptchaClient().execute(action);
    return result;
  }

  @override
  Future<RecaptchaClient> reCaptchaFetchClient(String key) async {
    RecaptchaClient client = await Recaptcha.fetchClient(key);
    return client;
  }

  @override
  Future<bool> postQrCodeLogin(UpdateQrCodeLoginRequest request) async {
    final res = await qrCodeLoginService.postQrCodeLogin(request);
    if (res != null) {
      return res;
    }
    throw NullResponseException('post qr code login response is null');
  }

  @override
  Future<bool> forgotPassword(ForgotPasswordRequest request) async {
    final res = await accountService.forgotPassword(request);
    if (res != null) {
      return true;
    }
    throw NullResponseException('forgot password response is null');
  }

  @override
  Future<bool> officialAccountQRSignInVerifyToken(OAQRVerifyTokenRequest request) async {
    final res = await authApiServiceNew.officialAccountQRSignInVerifyToken(request);
    return res;
  }

  @override
  Future<AuthLoginEntity> register(AuthRegisterRequest request) async {
    final httpResp = await authApiServiceNew.register(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<void> verifyUChatID(String request) async {
    await authApiServiceNew.verifyUChatID(request);
  }

  @override
  Future<VerifyOtpEntity> verifyOtp(VerifyOTPRequest request) async {
    final httpResp = await authApiServiceNew.verifyOTP(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<OtpEntity> linkAccountWithEmail(LinkEmailOtpRequest request) async {
    final httpResp = await authApiServiceNew.linkAccountWithEmail(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<UserEntity> verifyOtpLinkEmail(LinkEmailVerifyOtpRequest request) async {
    final httpResp = await authApiServiceNew.linkEmailVerifyOtp(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<void> setPassword(ChangePasswordRequest request) async {
    await authApiServiceNew.setPassword(request);
  }

  @override
  Future<void> clearOtpResponse(String phoneOrEmail) async {
    final configKey = ConfigDb.savedOtpResponseConfigKey(phoneOrEmail);
    await configGeneral.clearConfig(key: configKey);
  }

  @override
  Future<OtpEntity> getOtpResponse(String phoneOrEmail) async {
    final configKey = ConfigDb.savedOtpResponseConfigKey(phoneOrEmail);
    final config = await configGeneral.getString(key: configKey);
    if (config != null) {
      return OtpResponse.fromStringJson(config).toEntity();
    }
    throw Exception('OtpResponse not found');
  }

  @override
  Future<void> saveOtpResponse(SaveOtpResponseRequest request) async {
    final configKey = ConfigDb.savedOtpResponseConfigKey(request.phoneOrEmail);
    configGeneral.saveConfig(
      key: configKey,
      value: OtpResponse.fromEntity(request.otpEntity).toStringJson(),
    );
  }

  @override
  Future<CheckUserForgotPasswordEntity> checkUserForgotPassword(CheckUserForgotPasswordRequest request) async {
    final httpResp = await authApiServiceNew.checkUserForgotPassword(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<OtpEntity> getOtpForgotPassword(GetOtpForgotPasswordRequest request) async {
    // There is no socket for this action, because preventing about 'exclusive-token'
    // Socket cannot sent it anyway

    final httpResp = await authApiServiceNew.getOtpForgotPassword(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<AuthCodeVerifyEntity?> authCodeVerifyToken(AuthCodeVerifyTokenRequest request) async {
    final res = await authApiServiceNew.authCodeVerifyToken(request);

    return res?.toEntity();
  }

  @override
  Future<OtpEntity> getOtpSettingAccount(GetOtpSettingAccountRequest request) async {
    // There is no socket for this action, because preventing about 'exclusive-token'
    // Socket cannot sent it anyway

    final httpResp = await authApiServiceNew.getOtpSettingAccount(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<VerifyOtpEntity> verifyOtpTwoFa(VerifyOtpSettingAccountRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await authSocketService.verifyOtpTwoFa(request);
        if (socketResp != null) {
          return socketResp.toEntity();
        }
      } on ApiException catch (e) {
        final exception = e.toApiErrorMap();
        if (exception != null) throw exception;
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('verifyOtpTwoFa with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await authApiServiceNew.verifyOtpTwoFa(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<CheckPasswordRequiredEntity> checkPasswordRequired() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await authSocketService.checkPasswordRequired();
        if (socketResp != null) {
          return socketResp.toEntity();
        }
        throw NullResponseException();
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        if (e is NullResponseException) {
          rethrow;
        }
        _log.w('checkPasswordRequired with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await authApiServiceNew.checkPasswordRequired();
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  VerifyPasswordSettingAccountEntity _handleVerifyPasswordSettingAccountResponse(
      VerifyPasswordSettingAccountResponse? response) {
    if (response == null) {
      throw NullResponseException();
    }
    if (response is VerifyPasswordSettingAccountUnable2faResponse) {
      return response.toEntity();
    } else if (response is VerifyPasswordSettingAccountEnable2faResponse) {
      return response.toEntity();
    }
    // This line should ideally not be reached if the response types are exhaustive
    // and one of the conditions above is met.
    // Consider if there's a default or error entity to return,
    // or if this indicates an unhandled response type.
    throw Exception('Unknown VerifyPasswordSettingAccountResponse type');
  }

  @override
  Future<VerifyPasswordSettingAccountEntity> verifyPasswordSettingAccount(
      VerifyPasswordSettingAccountRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await authSocketService.verifyPasswordSettingAccount(request);
        return _handleVerifyPasswordSettingAccountResponse(response);
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        if (e is NullResponseException) {
          rethrow;
        }
        _log.w('checkPasswordRequired with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResponse = await authApiServiceNew.verifyPasswordSettingAccount(request);
    return _handleVerifyPasswordSettingAccountResponse(httpResponse);
  }

  @override
  Future<void> validateNewEmailSettingAccount(ValidateNewEmailSettingAccountRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await authSocketService.validateNewEmailSettingAccount(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('validateNewEmailSettingAccount with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await authApiServiceNew.validateNewEmailSettingAccount(request);
  }

  @override
  Future<void> updateEmailSettingAccount(UpdateEmailSettingAccountRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await authSocketService.updateEmailSettingAccount(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('updateEmailSettingAccount with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await authApiServiceNew.updateEmailSettingAccount(request);
  }

  @override
  Future<void> validateNewPassword(ValidateNewPasswordRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await authSocketService.validateNewPassword(request);
        return;
      } on ApiException catch (e) {
        final exception = e.toApiErrorMap();
        if (exception != null) throw exception;
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('validateNewPassword with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await authApiServiceNew.validateNewPassword(request);
  }

  @override
  Future<void> updateNewPassword(UpdateNewPasswordRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await authSocketService.updateNewPassword(request);
        return;
      } on ApiException catch (e) {
        final exception = e.toApiErrorMap();
        if (exception != null) throw exception;
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('updateNewPassword with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await authApiServiceNew.updateNewPassword(request);
  }

  @override
  Future<void> deleteAccount(DeleteAccountRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await authSocketService.deleteAccount(request);
        return;
      } catch (e, stackTrace) {
        _log.w('deleteAccount with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await authApiServiceNew.deleteAccount(request);
  }

  @override
  Future<void> multifactorUpdate(MultifactorUpdateSettingRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await authSocketService.multifactorUpdate(request);
        return;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('multifactorUpdate with socket error. fallback to http request...', e, stackTrace);
      }
    }
    await authApiServiceNew.multifactorUpdate(request);
  }

  MultifactorValidateEntity _handleMultifactorValidateResponse(MultifactorValidateResponse? response) {
    if (response == null) {
      throw NullResponseException();
    }
    if (response is MultifactorValidateTurnOffResponse) {
      return response.toEntity();
    } else if (response is MultifactorValidateTurnOnResponse) {
      return response.toEntity();
    }
    // This line should ideally not be reached if the response types are exhaustive
    // and one of the conditions above is met.
    // Consider if there's a default or error entity to return,
    // or if this indicates an unhandled response type.
    throw Exception('Unknown MultifactorValidateSettingResponse type');
  }

  @override
  Future<MultifactorValidateEntity> multifactorValidate(MultifactorValidateSettingRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await authSocketService.multifactorValidate(request);
        return _handleMultifactorValidateResponse(socketResp);
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        if (e is NullResponseException) {
          rethrow;
        }
        _log.w('multifactorValidate with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await authApiServiceNew.multifactorValidate(request);
    return _handleMultifactorValidateResponse(httpResp);
  }

  @override
  Future<PaginationPayload<GetSessionsListResponse>?> getSessionsList(GetSessionsListRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await authSocketService.getSessionsListResponse(request);
      } catch (e, stackTrace) {
        _log.w('getSessionsList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await authApiServiceNew.getSessionsListResponse(request);
  }

  @override
  Future<void> deleteSession(DeleteSessionRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await authSocketService.deleteSession(request);
      } catch (e, stackTrace) {
        _log.w('deleteSession with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await authApiServiceNew.deleteSession(request);
  }

  @override
  Future<void> deleteSessionsList(String request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await authSocketService.deleteSessionsList(request);
      } catch (e, stackTrace) {
        _log.w('deleteSessionsList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await authApiServiceNew.deleteSessionsList(request);
  }

  @override
  Future<SocialLinkEntity> settingAccountLinkAccountWithGoogle(UpdateLinkingAccountWithSocialRequest params) async {
    final response = await socialAuthApiService.settingAccountLinkAccountWithGoogle(params);

    if (response == null) {
      throw NullResponseException();
    }

    return response.toEntity();
  }

  @override
  Future<SocialLinkEntity> settingAccountUnlinkAccountWithGoogle(String actionToken) async {
    final response = await socialAuthApiService.settingAccountUnlinkAccountWithGoogle(actionToken);

    if (response == null) {
      throw NullResponseException();
    }

    return response.toEntity();
  }

  @override
  Future<SocialLinkEntity> settingAccountLinkAccountWithApple(UpdateLinkingAccountWithSocialRequest params) async {
    final response = await socialAuthApiService.settingAccountLinkAccountWithApple(params);

    if (response == null) {
      throw NullResponseException();
    }

    return response.toEntity();
  }

  @override
  Future<SocialLinkEntity> settingAccountUnlinkAccountWithApple(String actionToken) async {
    final response = await socialAuthApiService.settingAccountUnlinkAccountWithApple(actionToken);

    if (response == null) {
      throw NullResponseException();
    }

    return response.toEntity();
  }

  @override
  Future<SocialLinkEntity> settingAccountLinkAccountWithFacebook(
    UpdateLinkingAccountWithSocialRequest params,
  ) async {
    final response = await socialAuthApiService.settingAccountLinkAccountWithFacebook(params);

    if (response == null) {
      throw NullResponseException();
    }

    return response.toEntity();
  }

  @override
  Future<SocialLinkEntity> settingAccountUnlinkAccountWithFacebook(String actionToken) async {
    final response = await socialAuthApiService.settingAccountUnlinkAccountWithFacebook(actionToken);

    if (response == null) {
      throw NullResponseException();
    }

    return response.toEntity();
  }

  @override
  Future<GetOtpMethodForgotPasswordResponse> getOtpMethodForgotPassword(
    GetOtpMethodForgotPasswordRequest request,
  ) async {
    final result = await authApiServiceNew.getOtpMethodForgotPassword(request);

    if (result == null) {
      throw NullResponseException('getOtpMethodForgotPassword response is null');
    }

    return result;
  }

  @override
  Future<VerifyTokenForgotPasswordResponse> verifyTokenForgotPassword(VerifyTokenForgotPasswordRequest request) async {
    final result = await authApiServiceNew.verifyTokenForgotPassword(request);

    if (result == null) {
      throw NullResponseException('verifyTokenForgotPassword response is null');
    }

    return result;
  }

  @override
  Future<void> validateForgotPassword(ValidateForgotPasswordRequest request) async {
    return await authApiServiceNew.validateForgotPassword(request);
  }

  @override
  Future<OtpEntity> getOtpTwoFaLogin(GetOtpTwoFaLoginRequest request) async {
    final httpResp = await authApiServiceNew.getOtpTwoFaLogin(request);
    if (httpResp != null) {
      return httpResp.toEntity();
    }
    throw NullResponseException();
  }

  @override
  Future<UserResponse?> updateAccountSetting(UpdateAccountSettingRequest param) async {
    final response = await accountService.updateAccountSetting(param);

    if (response == null) {
      throw NullResponseException();
    }

    return response;
  }
}
