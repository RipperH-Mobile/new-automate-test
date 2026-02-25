import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/features/auth/data/models/requests/verify_password_setting_account_request.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_password_setting_account_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_validate_password_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/enter_password_base_controller.dart';
import 'package:uchat/features/auth/presentation/managers/setting_account_forgot_password_flow_manager.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class SettingAccountValidatePasswordController extends EnterPasswordBaseController {
  final SettingAccountValidatePasswordArguments args;
  final SettingAccountForgotPasswordFlowManager forgotPasswordFlowManager;

  SettingAccountValidatePasswordController({
    required this.args,
    required this.forgotPasswordFlowManager,
  });

  final isContinueButtonDisable = false.obs;

  @override
  int? get cooldown => null;

  @override
  void onContinue() async {
    // Don't put this inside the try-catch block, otherwise it will end up executing the code in the finally block
    if (isContinueButtonDisable.value) return;

    try {
      isContinueButtonDisable.value = true;
      UChatLoading.show();

      final entity = await GetIt.I<VerifyPasswordSettingAccountUseCase>()
          .call(VerifyPasswordSettingAccountRequest(
            password: passwordCtl.text,
          ))
          .timeout(const Duration(seconds: 30));

      isContinueButtonDisable.value = false;
      await UChatLoading.hide();
      Get.back(result: entity);
    } catch (e, stackTrace) {
      if (e is ApiException) {
        if (e.type == 'ERR_ACCOUNT_LIMIT_PASSWORD_VALIDATION') {
          passwordAttempts.value = e.data?.counter ?? 0;
          errorMessage.value = 'The password you entered is incorrect. Please try again'.tr;
        } else if (e.type == 'ERR_VALIDATE_PASSWORD_COOLDOWN') {
          errorMessage.value = 'Too many incorrect attempts'.tr;
          cooldownTime.value = e.data?.cooldown ?? 0;
          passwordAttempts.value = 0;
          startCooldown();
        } else {
          _log.e('API error during password validation.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: ExceptionHandler.handle(e),
          );
        }
      } else if (e is TimeoutException) {
        _log.e('Password validation failed, timeout.', e, stackTrace);
        UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
      } else if (e is DioException) {
        _log.e('Password validation failed, connection error.', e, stackTrace);
        if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.connectionError) {
          UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
        }
      } else {
        _log.e('Password validation error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    } finally {
      isContinueButtonDisable.value = false;
      await UChatLoading.hide();
    }
  }

  @override
  void onForgotPassword() async {
    forgotPasswordFlowManager.accountSettingFlow();
  }

  String get getOtpTitle {
    if (args.socialActionType != null) {
      return args.socialActionType!.title;
    }

    return args.actionType.title;
  }
}
