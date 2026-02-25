import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_otp_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_setting_account_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

abstract class IGetOtpUseCase<P, R> {
  R createRequest(P params);
  Future<OtpEntity> execute(R params);
}

class GetOtpUseCaseFactory {
  static IGetOtpUseCase create(AuthenticationActionType actionType) {
    switch (actionType) {
      case AuthenticationActionType.forgotPassword:
        return _GetOtpForgotPasswordUseCase();
      default:
        return _GetOtpSettingAccountUseCase();
    }
  }
}

class _GetOtpForgotPasswordUseCase
    implements IGetOtpUseCase<SettingAccountOtpVerifyArguments, GetOtpForgotPasswordRequest> {
  late final GetOtpForgotPasswordUseCase getOtpUseCase = GetIt.I<GetOtpForgotPasswordUseCase>();

  @override
  GetOtpForgotPasswordRequest createRequest(SettingAccountOtpVerifyArguments params) {
    final phoneOrEmail = params.method == SelectedOtpType.phone ? params.phoneNumber : params.email;
    return GetOtpForgotPasswordRequest(
      phoneOrEmail: phoneOrEmail ?? '',
      isForgotPassword: true,
      isEmail: params.method == SelectedOtpType.email,
      isPhoneNumber: params.method == SelectedOtpType.phone,
    );
  }

  @override
  Future<OtpEntity> execute(GetOtpForgotPasswordRequest request) {
    return getOtpUseCase.call(request);
  }
}

class _GetOtpSettingAccountUseCase
    implements IGetOtpUseCase<SettingAccountOtpVerifyArguments, GetOtpSettingAccountRequest> {
  late final GetOtpSettingAccountUseCase getOtpUseCase = GetIt.I<GetOtpSettingAccountUseCase>();

  @override
  GetOtpSettingAccountRequest createRequest(SettingAccountOtpVerifyArguments params) {
    return GetOtpSettingAccountRequest(
      phoneNumber: params.method == SelectedOtpType.phone ? params.phoneNumber : null,
      email: params.method == SelectedOtpType.email ? params.email : null,
      actionName: params.actionType,
    );
  }

  @override
  Future<OtpEntity> execute(GetOtpSettingAccountRequest request) {
    return getOtpUseCase.call(request);
  }
}
