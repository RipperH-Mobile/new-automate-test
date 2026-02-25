import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/features/auth/data/models/requests/change_password_request.dart';
import 'package:uchat/features/auth/domain/entities/password_condition_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/set_password_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/login_welcome_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class SetupPasswordController extends GetxController {
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

  void onLater() {
    UserController.instance.checkAndResetUserSyncCompleted(
      onSyncComplete: () {
        Get.offAllNamed(Routes.home);
        UserController.instance.fetchPendingRefundReasons();
      },
      onSyncNotComplete: () {
        Get.offAllNamed(
          Routes.loginWelcome,
          arguments: LoginWelcomeArguments(
            waitSyncUserOnly: true,
          ),
        );
      },
    );
  }

  void onContinue() async {
    validateConfirmPassword();
    if (isValid) {
      final request = ChangePasswordRequest(
        password: confirmPassword.value,
        newPassword: confirmPassword.value,
      );
      UChatLoading.show();
      try {
        await GetIt.I<SetPasswordUseCase>().call(request);
        await UChatLoading.hide();
        Get.offAllNamed(Routes.home);
      } catch (e, stackTrace) {
        await UChatLoading.hide();
        _log.e('Error setting up password', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }
}
