import 'dart:async';

import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as lib_phone_number;
import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:get/get.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/auth/domain/entities/verify_password_setting_account_entity.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_otp_verify_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/setting_account_validate_password_arguments.dart';
import 'package:uchat/features/auth/presentation/arguments/two_fa_otp_receipt_method_arguments.dart';
import 'package:uchat/features/setting/domain/use_cases/check_can_change_phone_number_use_case.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingAccountPhoneNumberController extends GetxController {
  final CheckPasswordRequiredUseCase checkPasswordRequiredUseCase;
  final CheckCanChangePhoneNumberUseCase checkCanChangePhoneNumberUseCase;

  SettingAccountPhoneNumberController({
    required this.checkPasswordRequiredUseCase,
    required this.checkCanChangePhoneNumberUseCase,
  });

  final currentCountry = Rx<lib_phone_number.CountryWithPhoneCode?>(null);

  final currentPhoneNumber = ''.obs;

  StreamSubscription? _userUpdateSub;

  @override
  void onInit() async {
    await lib_phone_number.init();
    _updateCountry();
    _updatePhoneNumber();
    _userUpdateSub = eventBus.on<UserUpdateEvent>().listen(
      (event) async {
        _updatePhoneNumber();
      },
    );
    super.onInit();
  }

  @override
  void onClose() async {
    await _userUpdateSub?.cancel();
    super.onClose();
  }

  // ------------------------------------------------------------------
  // 1.  Detect country from the stored
  // ------------------------------------------------------------------
  Future<void> _updateCountry() async {
    final rawPhoneNumber = UserController.instance.currentUser.value?.phoneNumber;

    // Fallback → Thailand
    final List<lib_phone_number.CountryWithPhoneCode> supportedCountries = lib_phone_number.CountryManager().countries;
    final fallback = supportedCountries.firstWhere((e) => e.countryCode == 'TH');
    currentCountry.value = fallback;

    if (rawPhoneNumber == null || rawPhoneNumber.isEmpty) return;

    try {
      final parsed = dlib.PhoneNumberUtil.instance.parse(rawPhoneNumber, 'ZZ');
      final iso2 = dlib.PhoneNumberUtil.instance.getRegionCodeForNumber(parsed);
      final match = supportedCountries.firstWhereOrNull((c) => c.countryCode == iso2);

      currentCountry.value = match ?? fallback;
    } catch (e, strackTrace) {
      _log.e('Could not derive country from "$rawPhoneNumber":', e, strackTrace);
      currentCountry.value = fallback;
    }
  }

  // ------------------------------------------------------------------
  // 2.  Format the number nicely for display each time it changes
  // ------------------------------------------------------------------
  void _updatePhoneNumber() {
    final rawPhoneNumber = UserController.instance.currentUser.value?.phoneNumber;

    if (rawPhoneNumber == null || rawPhoneNumber.isEmpty) {
      currentPhoneNumber('Phone number not found'.tr);
      return;
    }

    try {
      final parsed = dlib.PhoneNumberUtil.instance.parse(rawPhoneNumber, 'ZZ');
      final formatted = dlib.PhoneNumberUtil.instance.format(parsed, dlib.PhoneNumberFormat.international);

      currentPhoneNumber(formatted); // “+66 81 234 5678”
    } catch (e, st) {
      _log.w('Could not format phone "$rawPhoneNumber": $e', e, st);
      currentPhoneNumber(rawPhoneNumber); // fall back to raw string
    }
  }

  void onContinue() async {
    try {
      await checkCanChangePhoneNumberUseCase.call(NoParams());
      final response = await checkPasswordRequiredUseCase.call(NoParams());
      if (response.passwordRequired) {
        _goToSettingAccountPhoneNumberChangeWithPassword();
      } else {
        _goToSettingAccountPhoneNumberChangeWithOtp();
      }
    } on FailedHostLookupException catch (e, stackTrace) {
      _log.e('checkPasswordRequired failed, no internet.', e, stackTrace);
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('checkPasswordRequired error.', e, stackTrace);

      if (e is ApiException && e.type == 'ERR_ACCOUNT_PHONE_NUMBER_RECENTLY_CHANGE') {
        UChatNewDialog.showSingleButtonDialog(
          context: Get.context!,
          confirmText: 'Close'.tr,
          title: 'Phone number cannot be changed at this time'.tr,
          description:
              'If you have not logged in for at least 24 hours, you will not be able to change your phone number.'.tr,
          confirmTextColor: Get.context!.theme.appColors.textLight,
        );
        return;
      }

      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: ExceptionHandler.handle(e),
      );
    }
  }

  void _goToSettingAccountPhoneNumberChangeWithPassword() async {
    final validatePasswordResult = await Get.toNamed(
      Routes.settingAccountValidatePassword,
      arguments: SettingAccountValidatePasswordArguments(
        actionType: AuthenticationActionType.settingPhoneNumber,
      ),
    );

    if (validatePasswordResult is VerifyPasswordSettingAccountEnable2faEntity) {
      final verifyOtpResult = await Get.toNamed(
        Routes.twoFaOtpReceiptMethod,
        arguments: TwoFaOtpReceiptMethodArguments(
          actionType: AuthenticationActionType.settingPhoneNumber,
          method: SelectedOtpType.phone,
        ),
      );

      if (verifyOtpResult == null) return;

      Get.toNamed(Routes.settingAccountPhoneNumberChange);
    } else if (validatePasswordResult is VerifyPasswordSettingAccountUnable2faEntity) {
      Get.toNamed(Routes.settingAccountPhoneNumberChange);
    }
  }

  void _goToSettingAccountPhoneNumberChangeWithOtp() async {
    final result = await Get.toNamed(
      Routes.settingAccountOtpRequest,
      arguments: SettingAccountOtpVerifyArguments(
        actionType: AuthenticationActionType.settingPhoneNumber,
        phoneNumber: UserController.instance.currentUser.value?.phoneNumber,
        method: SelectedOtpType.phone,
      ),
    );

    if (result == null) {
      return;
    }

    Get.toNamed(Routes.settingAccountPhoneNumberChange);
  }
}
