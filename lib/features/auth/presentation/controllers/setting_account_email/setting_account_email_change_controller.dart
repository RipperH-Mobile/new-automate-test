import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/auth/data/models/requests/update_email_setting_account_request.dart';
import 'package:uchat/features/auth/data/models/requests/validate_new_email_setting_account_request.dart';
import 'package:uchat/features/auth/domain/use_cases/update_email_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_new_email_setting_account_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_email_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_result_arguments.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/enter_email_base_controller.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class SettingAccountEmailChangeController extends EnterEmailBaseController {
  final ValidateNewEmailSettingAccountUseCase validateNewEmailSettingAccountUseCase;
  final UpdateEmailSettingAccountUseCase updateEmailSettingAccountUseCase;
  final SettingAccountEmailArguments arguments;

  SettingAccountEmailChangeController({
    required this.validateNewEmailSettingAccountUseCase,
    required this.updateEmailSettingAccountUseCase,
    required this.arguments,
  });

  @override
  void onContinue() async {
    final validateEmailResult = await _validateEmail();

    if (validateEmailResult == null) return;

    _changeEmail(
      email: validateEmailResult.phoneOrEmail,
      actionToken: validateEmailResult.actionToken,
    );
  }

  Future<SettingAccountOtpVerifyResultArguments?> _validateEmail() async {
    try {
      UChatLoading.show();
      await validateNewEmailSettingAccountUseCase.call(
        ValidateNewEmailSettingAccountRequest(
          newEmail: emailCtl.text,
        ),
      );
      await UChatLoading.hide();

      final result = await Get.toNamed(
        Routes.settingAccountOtpRequest,
        arguments: SettingAccountOtpVerifyArguments(
          actionType:
              arguments.isChangeEmail ? AuthenticationActionType.changeEmail : AuthenticationActionType.settingEmail,
          email: emailCtl.text,
          method: SelectedOtpType.email,
          canGodModeByPassOtp: false,
        ),
      );

      if (result is SettingAccountOtpVerifyResultArguments) {
        return result;
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ApiException) {
        if (e.type == 'ERR_ACCOUNT_EMAIL_ALREADY_EXIST') {
          await UChatLoading.hide();
          errorMessage.value = 'This email cannot be used.'.tr;
        } else {
          _log.e('API error during password validation.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: ExceptionHandler.handle(e),
          );
        }
      }
    }
    return null;
  }

  void _changeEmail({
    required String email,
    required String actionToken,
  }) async {
    try {
      UChatLoading.show();
      await updateEmailSettingAccountUseCase.call(
        UpdateEmailSettingAccountRequest(
          newEmail: email,
          actionToken: actionToken,
        ),
      );
      await UChatLoading.hide();

      AppToast.showToast(
        context: Get.context!,
        message: 'You\'ve changed your email.'.tr,
        icon: Icon(
          Icons.check_circle_rounded,
          size: AppSize.size6,
          color: Get.context?.theme.appColors.iconInverse,
          blendMode: BlendMode.srcIn,
        ),
      );

      // back to setting account email
      Get.offNamedUntil(
        Routes.settingAccountEmailV2,
        (r) => r.settings.name == Routes.home,
      );
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ApiException) {
        if (e.type == 'ERR_ACCOUNT_ACTION_TOKEN_EXPIRED') {
          UChatDialog.showActionTokenExpireDialog();
        }
      } else if (e is FailedHostLookupException) {
        _log.e('updateEmailSettingAccount failed, no internet.', e, stackTrace);
        UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      } else {
        _log.e('updateEmailSettingAccount error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }
}
