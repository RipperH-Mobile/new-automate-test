import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/auth/domain/factories/update_new_password_usecase_factory.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_confirm_new_password_arguments.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingAccountConfirmNewPasswordController extends GetxController {
  final SettingAccountConfirmNewPasswordArguments args;
  final IUpdateNewPasswordUseCase updatePasswordUseCase;

  SettingAccountConfirmNewPasswordController({
    required this.args,
    required this.updatePasswordUseCase,
  });

  final newPasswordController = TextEditingController();
  final RxBool isNewPasswordObscured = true.obs;
  final RxBool isPasswordValid = false.obs;
  final RxBool showPasswordNotMatchWarning = false.obs;
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
    showPasswordNotMatchWarning.value = false;
    isPasswordValid.value = password.isNotEmpty;
  }

  Future<void> submitNewPassword() async {
    if (args.newPassword != newPasswordController.text) {
      showPasswordNotMatchWarning.value = true;
      return;
    }

    try {
      UChatLoading.show();
      isLoading.value = true;
      showPasswordNotMatchWarning.value = false;

      final request = updatePasswordUseCase.createRequest(
        params: args,
        newPassword: newPasswordController.text,
      );
      await updatePasswordUseCase.execute(request);
      await UserController.instance.getCurrentUserProfileFromServer();

      UChatLoading.hide();

      if (args.enableChangePasswordSuccessToast) {
        AppToast.showToast(
          context: Get.context!,
          message: 'You\'ve changed password.'.tr,
          icon: Icon(
            Icons.check_circle_rounded,
            size: AppSize.size6,
            color: Get.context?.theme.appColors.iconInverse,
            blendMode: BlendMode.srcIn,
          ),
        );
      }

      Get.back(result: true);
    } on ApiException catch (e) {
      UChatLoading.hide();
      _log.e('API Error setting new password: ${e.message}', e, e.apiStacktrace);

      switch (e.type) {
        case 'ERR_ACCOUNT_ACTION_TOKEN_EXPIRED':
          Get.snackbar('Warning', 'Please try again');
          Get.back();
          break;
        default:
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: ExceptionHandler.handle(e),
          );
          break;
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
