import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/data/models/requests/forgot_password_request.dart';
import 'package:uchat/features/auth/domain/entities/password_condition_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/forgot_password_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ForgotPasswordController extends GetxController {
  final ForgotPasswordArguments args;

  ForgotPasswordController({
    required this.args,
  });

  final TextEditingController passwordController = TextEditingController();
  final RxString confirmPassword = ''.obs;
  final Rx<PasswordConditionEntity> passwordCondition = PasswordConditionEntity().obs;
  final RxnString confirmPasswordError = RxnString('');

  bool get isValid => passwordCondition.value.isValid && confirmPasswordError.value == null;

  void onPasswordChanged(String password) {
    passwordCondition.value = passwordCondition.value.copyWith(
      isLengthValid: password.length >= 8,
      isLowercaseValid: password.contains(RegExp(r'[a-z]')),
      isUppercaseValid: password.contains(RegExp(r'[A-Z]')),
      isNumberValid: password.contains(RegExp(r'[0-9]')),
      isSymbolValid: password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
    );
  }

  void onConfirmPasswordChanged(String password) {
    confirmPassword.value = password;
    confirmPasswordError.value = null;
  }

  void validateConfirmPassword() {
    if (confirmPassword.value != passwordController.text) {
      confirmPasswordError.value = 'Password do not match, Please try again.'.tr;
    } else {
      confirmPasswordError.value = null;
    }
  }

  void onContinue() {
    validateConfirmPassword();
    if (isValid) {
      updatePassword();
    }
  }

  Future<void> updatePassword() async {
    try {
      final request = ForgotPasswordRequest(
        actionToken: args.actionToken,
        phoneOrEmail: args.phoneOrEmail,
        password: confirmPassword.value,
      );

      final response = await GetIt.I<ForgotPasswordUseCase>().call(request);

      if (response == true) {
        _log.i('Password reset successfully');

        Get.offAllNamed(Routes.forgotPasswordSetupSuccess);
      } else {
        _log.e('Failed to forgot password. Response from server : $response');
      }
    } catch (e, stackTrace) {
      handleException(
        e,
        onUnknownException: () {
          _log.e('forgotPassword error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
          );
        },
      );
    }
  }
}
