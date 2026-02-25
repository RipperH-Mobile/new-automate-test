import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_request.dart';
import 'package:uchat/features/auth/data/models/requests/verify_otp_setting_account_request.dart';
import 'package:uchat/features/auth/domain/entities/verify_otp_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_otp_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

abstract class IVerifyOtpUseCase<P, R> {
  R createRequest(P params);
  Future<VerifyOtpEntity> execute(R params);
}

class VerifyOtpUseCaseFactory {
  static IVerifyOtpUseCase create(AuthenticationActionType actionType) {
    switch (actionType) {
      case AuthenticationActionType.forgotPassword:
        return _VerifyOtpForgotPasswordUseCase();
      default:
        return _VerifyOtpSettingAccountUseCase();
    }
  }
}

class _VerifyOtpForgotPasswordUseCase implements IVerifyOtpUseCase<SettingAccountOtpVerifyArguments, VerifyOTPRequest> {
  late final VerifyOtpUseCase verifyOtpUseCase = GetIt.I<VerifyOtpUseCase>();

  @override
  VerifyOTPRequest createRequest(SettingAccountOtpVerifyArguments params) {
    final phoneOrEmail = params.method == SelectedOtpType.phone ? params.phoneNumber : params.email;
    return VerifyOTPRequest(
      token: params.otpEntity?.token ?? '',
      otp: params.otp ?? '',
      phoneOrEmail: phoneOrEmail ?? '',
      actionName: params.actionType,
    );
  }

  @override
  Future<VerifyOtpEntity> execute(VerifyOTPRequest request) {
    return verifyOtpUseCase.call(request);
  }
}

class _VerifyOtpSettingAccountUseCase
    implements IVerifyOtpUseCase<SettingAccountOtpVerifyArguments, VerifyOtpSettingAccountRequest> {
  late final VerifyOtpSettingAccountUseCase verifyOtpUseCase = GetIt.I<VerifyOtpSettingAccountUseCase>();

  @override
  VerifyOtpSettingAccountRequest createRequest(SettingAccountOtpVerifyArguments args) {
    return VerifyOtpSettingAccountRequest(
      token: args.otpEntity?.token ?? '',
      otp: args.otp ?? '',
      phoneNumber: args.method == SelectedOtpType.phone ? args.phoneNumber : null,
      email: args.method == SelectedOtpType.email ? args.email : null,
    );
  }

  @override
  Future<VerifyOtpEntity> execute(VerifyOtpSettingAccountRequest request) {
    return verifyOtpUseCase.call(request);
  }
}
