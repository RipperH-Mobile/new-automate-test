import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/features/auth/domain/factories/validate_new_password_usecase_factory.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_confirm_new_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_create_new_password_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingAccountCreateNewPasswordController extends GetxController {
  final SettingAccountCreateNewPasswordArguments args;
  final IValidateNewPasswordUseCase validateNewPasswordUseCase;

  SettingAccountCreateNewPasswordController({
    required this.args,
    required this.validateNewPasswordUseCase,
  });

  final newPasswordController = TextEditingController();
  final RxBool isNewPasswordObscured = true.obs;
  final RxBool isLengthValid = false.obs;
  final RxBool hasLowercase = false.obs;
  final RxBool hasUppercase = false.obs;
  final RxBool hasNumber = false.obs;
  final RxBool hasSymbol = false.obs;
  final RxBool isPasswordValid = false.obs;
  final RxBool showOldPasswordWarning = false.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    newPasswordController.addListener(() {
      onPasswordChanged(newPasswordController.text);
    });
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    super.onClose();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordObscured.value = !isNewPasswordObscured.value;
  }

  void onPasswordChanged(String password) {
    showOldPasswordWarning.value = false;
    isLengthValid.value = password.length >= 8;
    hasLowercase.value = password.contains(RegExp(r'[a-z]'));
    hasUppercase.value = password.contains(RegExp(r'[A-Z]'));
    hasNumber.value = password.contains(RegExp(r'[0-9]'));
    hasSymbol.value = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    isPasswordValid.value =
        isLengthValid.value && hasLowercase.value && hasUppercase.value && hasNumber.value && hasSymbol.value;
  }

  Future<void> submitNewPassword() async {
    isLoading.value = true;
    showOldPasswordWarning.value = false;

    try {
      UChatLoading.show();
      final newPassword = newPasswordController.text;
      final request = validateNewPasswordUseCase.createRequest(
        params: args,
        newPassword: newPassword,
      );
      await validateNewPasswordUseCase.execute(request);
      UChatLoading.hide();

      final confirmNewPasswordResult = await Get.toNamed(
        Routes.settingAccountConfirmNewPassword,
        arguments: SettingAccountConfirmNewPasswordArguments(
          actionToken: args.actionToken,
          newPassword: newPassword,
          actionType: args.actionType,
          phoneOrEmail: args.phoneOrEmail,
          enableChangePasswordSuccessToast: args.enableChangePasswordSuccessToast,
        ),
      );

      if (confirmNewPasswordResult == null) return;

      Get.back(result: confirmNewPasswordResult);
    } on ApiException catch (e) {
      UChatLoading.hide();
      _log.e('API Error setting new password: ${e.message}', e, e.apiStacktrace);

      switch (e.type) {
        case 'ERR_ACCOUNT_DUPLICATE_OLD_PASSWORD':
          showOldPasswordWarning.value = true;
          break;
        case 'ERR_ACCOUNT_ACTION_TOKEN_EXPIRED':
          Get.snackbar('Warning', 'Please try again');
          Get.back();
          break;
        default:
          rethrow;
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      UChatLoading.hide();
      _log.e('submitNewPassword failed, no internet.', e, stackTrace);

      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      UChatLoading.hide();
      _log.e('Unexpected error setting new password: $e', e, stackTrace);

      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
