import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/validate_forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_password_request.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_new_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_create_new_password_arguments.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

abstract class IValidateNewPasswordUseCase<P, R> {
  R createRequest({
    required P params,
    required String newPassword,
  });
  Future<void> execute(R params);
}

class ValidateNewPasswordUseCaseFactory {
  static IValidateNewPasswordUseCase create(AuthenticationActionType actionType) {
    switch (actionType) {
      case AuthenticationActionType.forgotPassword:
        return _ValidateNewPasswordForgotPasswordUseCase();
      default:
        return _ValidateNewPasswordSettingAccountUseCase();
    }
  }
}

class _ValidateNewPasswordForgotPasswordUseCase
    implements IValidateNewPasswordUseCase<SettingAccountCreateNewPasswordArguments, ValidateForgotPasswordRequest> {
  late final ValidateForgotPasswordUseCase validateNewPasswordUseCase = GetIt.I<ValidateForgotPasswordUseCase>();

  @override
  ValidateForgotPasswordRequest createRequest({
    required SettingAccountCreateNewPasswordArguments params,
    required String newPassword,
  }) {
    return ValidateForgotPasswordRequest(
      accountId: params.accountId,
      token: params.actionToken,
      password: newPassword,
    );
  }

  @override
  Future<void> execute(ValidateForgotPasswordRequest request) {
    return validateNewPasswordUseCase.call(request);
  }
}

class _ValidateNewPasswordSettingAccountUseCase
    implements IValidateNewPasswordUseCase<SettingAccountCreateNewPasswordArguments, ValidateNewPasswordRequest> {
  late final ValidateNewPasswordUseCase validateNewPasswordUseCase = GetIt.I<ValidateNewPasswordUseCase>();

  @override
  ValidateNewPasswordRequest createRequest({
    required SettingAccountCreateNewPasswordArguments params,
    required String newPassword,
  }) {
    return ValidateNewPasswordRequest(
      newPassword: newPassword,
    );
  }

  @override
  Future<void> execute(ValidateNewPasswordRequest request) {
    return validateNewPasswordUseCase.call(request);
  }
}
