import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_result_arguments.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/enter_phone_number_base_controller.dart';
import 'package:uchat/features/setting/domain/params/check_new_phone_number_params.dart';
import 'package:uchat/features/setting/domain/params/update_phone_number_params.dart';
import 'package:uchat/features/setting/domain/use_cases/check_new_phone_number_use_case.dart';
import 'package:uchat/features/setting/domain/use_cases/update_phone_number_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class SettingAccountPhoneNumberChangeController extends EnterPhoneNumberBaseController {
  final CheckNewPhoneNumberUseCase checkNewPhoneNumberUseCase;
  final UpdatePhoneNumberUseCase updatePhoneNumberUseCase;

  SettingAccountPhoneNumberChangeController({
    required this.checkNewPhoneNumberUseCase,
    required this.updatePhoneNumberUseCase,
  });

  @override
  void onContinue() async {
    final validatePhoneNumberResult = await _validatePhoneNumber();

    if (validatePhoneNumberResult == null) return;

    _changePhoneNumber(
      phoneNumber: validatePhoneNumberResult.phoneOrEmail,
      actionToken: validatePhoneNumberResult.actionToken,
    );
  }

  Future<SettingAccountOtpVerifyResultArguments?> _validatePhoneNumber() async {
    try {
      final phoneNumber = phoneInputCtl.phoneNumber().phoneNumber;

      final newPhoneNumber = dlib.PhoneNumberUtil.instance.parse(phoneNumber, currentCountry.value?.countryCode);
      final phoneNumberFormat = dlib.PhoneNumberUtil.instance.format(newPhoneNumber, dlib.PhoneNumberFormat.e164);

      UChatLoading.show();
      await checkNewPhoneNumberUseCase.call(
        CheckNewPhoneNumberParams(
          newPhoneNumber: phoneNumberFormat,
        ),
      );

      await UChatLoading.hide();

      final result = await Get.toNamed(
        Routes.settingAccountOtpRequest,
        arguments: SettingAccountOtpVerifyArguments(
          actionType: AuthenticationActionType.settingPhoneNumber,
          phoneNumber: phoneNumberFormat,
          method: SelectedOtpType.phone,
          canGodModeByPassOtp: false,
        ),
      );

      if (result is SettingAccountOtpVerifyResultArguments) {
        return result;
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ApiException) {
        if (e.type == 'ERR_ACCOUNT_PHONE_NUMBER_ALREADY_EXIST') {
          errorMessagePhone.value = 'This number cannot be used.'.tr;
        } else {
          _log.e('API error during checkNewPhoneNumber validation.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: ExceptionHandler.handle(e),
          );
        }
      }
    }
    return null;
  }

  void _changePhoneNumber({
    required String phoneNumber,
    required String actionToken,
  }) async {
    try {
      UChatLoading.show();
      await updatePhoneNumberUseCase.call(
        UpdatePhoneNumberParams(
          newPhoneNumber: phoneNumber,
          actionToken: actionToken,
        ),
      );
      await UChatLoading.hide();

      AppToast.showToast(
        context: Get.context!,
        message: 'You\'ve changed your phone number.'.tr,
        icon: Icon(
          Icons.check_circle_rounded,
          size: AppSize.size6,
          color: Get.context?.theme.appColors.iconInverse,
          blendMode: BlendMode.srcIn,
        ),
      );

      // back to setting account phone number
      Get.offAllNamed(Routes.home);
      Get.toNamed(Routes.settingAccountPhoneNumber);
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      if (e is ApiException) {
        if (e.type == 'ERR_ACCOUNT_ACTION_TOKEN_EXPIRED') {
          UChatDialog.showActionTokenExpireDialog();
        }
      } else if (e is FailedHostLookupException) {
        _log.e('showDialogDeleteChat failed, no internet.', e, stackTrace);
        UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
      } else {
        _log.e('updatePhoneNumber validation error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: ExceptionHandler.handle(e),
        );
      }
    }
  }
}
