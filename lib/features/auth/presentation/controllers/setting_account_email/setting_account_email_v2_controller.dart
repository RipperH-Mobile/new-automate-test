import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_email_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_validate_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_receipt_method_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingAccountEmailV2Controller extends GetxController {
  final CheckPasswordRequiredUseCase checkPasswordRequiredUseCase;

  SettingAccountEmailV2Controller({
    required this.checkPasswordRequiredUseCase,
  });

  StreamSubscription? _userUpdateSub;

  final RxString email = ''.obs;

  final isContinueButtonDisable = false.obs;

  @override
  void onInit() {
    super.onInit();
    _updateEmail();
    _userUpdateSub = eventBus.on<UserUpdateEvent>().listen(
      (event) async {
        _updateEmail();
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    _userUpdateSub?.cancel();
  }

  void _updateEmail() {
    email(UserController.instance.currentUser.value?.email ?? 'Unregistered'.tr);
  }

  void onContinue({required bool isChangeEmail}) async {
    // Don't put this inside the try-catch block, otherwise it will end up executing the code in the finally block
    if (isContinueButtonDisable.value) return;

    try {
      isContinueButtonDisable.value = true;
      AppToast.showProcessingToast(Get.context!);

      final response = await checkPasswordRequiredUseCase.call(NoParams()).timeout(const Duration(seconds: 30));

      if (response.passwordRequired) {
        _goToSettingAccountEmailChangeWithPassword(isChangeEmail);
      } else {
        _goToSettingAccountEmailChangeWithOtp(isChangeEmail);
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('checkPasswordRequired failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on TimeoutException {
      _log.e('checkPasswordRequired failed, timeout.');
      UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
    } on DioException catch (e, stackTrace) {
      _log.e('checkPasswordRequired failed, connection error.', e, stackTrace);
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.connectionError) {
        UChatNewDialog.showConnectionErrorDialog(context: Get.context!);
      }
    } catch (e, stackTrace) {
      _log.e('checkPasswordRequired error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    } finally {
      isContinueButtonDisable.value = false;
      AppToast.hideToast(Get.context!);
    }
  }

  void _goToSettingAccountEmailChangeWithOtp(bool isChangeEmail) async {
    final result = await Get.toNamed(
      Routes.settingAccountOtpRequest,
      arguments: SettingAccountOtpVerifyArguments(
        actionType: isChangeEmail ? AuthenticationActionType.changeEmail : AuthenticationActionType.settingEmail,
        phoneNumber: UserController.instance.currentUser.value?.phoneNumber,
        method: SelectedOtpType.phone,
      ),
    );

    if (result == null) {
      return;
    }

    Get.toNamed(
      Routes.settingAccountEmailChange,
      arguments: SettingAccountEmailArguments(
        isChangeEmail: isChangeEmail,
      ),
    );
  }

  void _goToSettingAccountEmailChangeWithPassword(bool isChangeEmail) async {
    final validatePasswordResult = await Get.toNamed(
      Routes.settingAccountValidatePassword,
      arguments: SettingAccountValidatePasswordArguments(
        actionType: isChangeEmail ? AuthenticationActionType.changeEmail : AuthenticationActionType.settingEmail,
      ),
    );

    if (validatePasswordResult is VerifyPasswordSettingAccountEnable2faEntity) {
      final verifyOtpResult = await Get.toNamed(
        Routes.twoFaOtpReceiptMethod,
        arguments: TwoFaOtpReceiptMethodArguments(
          actionType: isChangeEmail ? AuthenticationActionType.changeEmail : AuthenticationActionType.settingEmail,
          method: SelectedOtpType.phone,
        ),
      );

      if (verifyOtpResult == null) return;

      Get.toNamed(
        Routes.settingAccountEmailChange,
        arguments: SettingAccountEmailArguments(
          isChangeEmail: isChangeEmail,
        ),
      );
    } else if (validatePasswordResult is VerifyPasswordSettingAccountUnable2faEntity) {
      Get.toNamed(
        Routes.settingAccountEmailChange,
        arguments: SettingAccountEmailArguments(
          isChangeEmail: isChangeEmail,
        ),
      );
    }
  }
}
