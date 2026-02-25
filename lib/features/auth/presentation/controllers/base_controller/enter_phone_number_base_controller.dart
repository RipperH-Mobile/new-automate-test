import 'dart:async';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as lib_phone_number;
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/domain/use_cases/get_enabled_country_list_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/reset_social_auth_use_case.dart';
import 'package:uchat/features/auth/presentation/views/widgets/enabled_counties_bottom_sheet_screen.dart';
import 'package:uchat/widgets/input/phone_number_input_uchat_controller.dart';
import 'package:uchat/use_cases/use_case.dart';

abstract class EnterPhoneNumberBaseController extends GetxController {
  final _log = useLogger();

  // Observables
  final RxString errorMessagePhone = ''.obs;

  final enabledCountries = Rx<List<lib_phone_number.CountryWithPhoneCode>>([]);
  final currentCountry = Rx<lib_phone_number.CountryWithPhoneCode?>(null);

  final isFocusedInputBox = false.obs;

  // Access custom phone input widget
  PhoneNumberInputUChatController get phoneInputCtl => Get.find<PhoneNumberInputUChatController>(tag: 'login');

  bool get enableContinueButton {
    final phone = phoneInputCtl.phoneNumber().phoneNumber ?? '';
    final phoneValid = phone.isNotEmpty && errorMessagePhone.value.isEmpty;
    return phoneValid;
  }

  @override
  void onInit() async {
    /// flutter_libphonenumber's init for every enabled countries data
    await lib_phone_number.init();
    phoneInputCtl.focusNodePhoneNumber.addListener(() {
      if (phoneInputCtl.focusNodePhoneNumber.hasFocus) {
        isFocusedInputBox.value = true;
      } else {
        isFocusedInputBox.value = false;
      }
    });
    initCurrentCountryData();

    super.onInit();
  }

  @override
  onClose() async {
    await resetSocialAuth();
    super.onClose();
  }

  Future<void> resetSocialAuth() async {
    try {
      await GetIt.I<ResetSocialAuthUseCase>().call(NoParams());
    } catch (e) {
      _log.e('resetSocialAuth error', e);
    }
  }

  void onPhoneCtlChanged(PhoneNumber value) {
    errorMessagePhone.value = '';
  }

  void onPhoneValidated(bool value) {
    validatePhone();
  }

  void clearPhone() {
    errorMessagePhone.value = '';
  }

  Future<void> validatePhone() async {
    final error = _validatePhoneInput();
    errorMessagePhone.value = error ?? '';
  }

  String? _validatePhoneInput() {
    final phoneNumber = phoneInputCtl.phoneNumber();
    if ((phoneNumber.phoneNumber?.isEmpty ?? false) || phoneNumber.phoneNumber == phoneNumber.dialCode) {
      return 'Please enter your phone number'.tr;
    } else if (!phoneInputCtl.isPhoneNumberValid()) {
      return 'Invalid phone number. Please try again'.tr;
    }
    return null;
  }

  void initCurrentCountryData() async {
    final List<lib_phone_number.CountryWithPhoneCode> supportedCountries = lib_phone_number.CountryManager().countries;
    currentCountry.value = supportedCountries.where((e) => e.countryCode == 'TH').first;

    final countries = await GetIt.I<GetEnabledCountryListUseCase>().call(NoParams());

    enabledCountries.value.addAll(supportedCountries.where((e) => countries.countryEnabled.contains(e.countryCode)));
    enabledCountries.value.sort((a, b) => (a.countryName ?? '').compareTo(b.countryName ?? ''));

    final indexTH = enabledCountries.value.indexWhere((e) => e.countryCode == 'TH');
    final indexTW = enabledCountries.value.indexWhere((e) => e.countryCode == 'TW');

    /// Move Taiwan to the top
    if (indexTW != -1) {
      final taiwan = enabledCountries.value.removeAt(indexTW);
      enabledCountries.value.insert(0, taiwan);
    }

    /// Move Thailand to the top
    if (indexTH != -1) {
      final thailand = enabledCountries.value.removeAt(indexTH);
      enabledCountries.value.insert(0, thailand);
    }

    /// At the end [Thailand] will be index[0] and [Taiwan] will be index[1]
    /// In case one or both of these are not on the [enabledCountries] list
    /// The sorting still be correct
  }

  void onOpenCountryListBottomSheet() async {
    if (enabledCountries.value.isEmpty) return;

    await showCupertinoModalBottomSheet(
      expand: true,
      context: Get.context!,
      builder: (_) {
        return EnabledCountriesBottomSheetScreen(
          countryList: enabledCountries.value,
          selectedCountryCode: currentCountry.value?.countryCode ?? 'TH',
          onSelectItem: (country) {
            Get.back();
            currentCountry.value = country;
            phoneInputCtl.phoneNumber.value = PhoneNumber();
            phoneInputCtl.onClearInputText();
          },
        );
      },
    );
  }

  // TODO: Implement this method in the derived class
  void onContinue();
}
