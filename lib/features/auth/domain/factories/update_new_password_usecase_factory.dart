import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/forgot_password_request.dart';
import 'package:uchat/features/auth/data/models/requests/update_new_password_request.dart';
import 'package:uchat/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/update_new_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_confirm_new_password_arguments.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';

abstract class IUpdateNewPasswordUseCase<P, R> {
  R createRequest({
    required P params,
    required String newPassword,
  });
  Future<void> execute(R params);
}

class UpdateNewPasswordUseCaseFactory {
  static IUpdateNewPasswordUseCase create(AuthenticationActionType actionType) {
    switch (actionType) {
      case AuthenticationActionType.forgotPassword:
        return _UpdateNewPasswordForgotPasswordUseCase();
      default:
        return _UpdateNewPasswordSettingAccountUseCase();
    }
  }
}

class _UpdateNewPasswordForgotPasswordUseCase
    implements IUpdateNewPasswordUseCase<SettingAccountConfirmNewPasswordArguments, ForgotPasswordRequest> {
  late final ForgotPasswordUseCase updateNewPasswordUseCase = GetIt.I<ForgotPasswordUseCase>();

  @override
  ForgotPasswordRequest createRequest({
    required SettingAccountConfirmNewPasswordArguments params,
    required String newPassword,
  }) {
    return ForgotPasswordRequest(
      actionToken: params.actionToken,
      phoneOrEmail: params.phoneOrEmail,
      password: newPassword,
    );
  }

  @override
  Future<void> execute(ForgotPasswordRequest request) {
    return updateNewPasswordUseCase.call(request);
  }
}

class _UpdateNewPasswordSettingAccountUseCase
    implements IUpdateNewPasswordUseCase<SettingAccountConfirmNewPasswordArguments, UpdateNewPasswordRequest> {
  late final UpdateNewPasswordUseCase updateNewPasswordUseCase = GetIt.I<UpdateNewPasswordUseCase>();

  @override
  UpdateNewPasswordRequest createRequest({
    required SettingAccountConfirmNewPasswordArguments params,
    required String newPassword,
  }) {
    return UpdateNewPasswordRequest(
      actionToken: params.actionToken,
      newPassword: newPassword,
    );
  }
  @override
  Future<void> execute(UpdateNewPasswordRequest request) {
    return updateNewPasswordUseCase.call(request);
  }
}
