import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_field/models/country_code_model.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/controllers/announcement_controller.dart';
import 'package:uchat/controllers/app_controller.dart';
import 'package:uchat/core/domain/use_cases/get_enabled_country_list_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/announcement/maintenance_dialog.dart';

final _log = useLogger();
const limitTimeInSeconds = 60;

class PhoneNumberInputUChatController extends GetxController {
  final GetEnabledCountryListUseCase getEnabledCountryListUseCase;

  PhoneNumberInputUChatController({
    required this.getEnabledCountryListUseCase,
  });

  final List<CountryCodeModel> desktopCountryEnabled = [
    CountryCodeModel(
      name: 'Thailand',
      dial_code: '+66',
      code: 'TH',
    ),
  ].obs;
  // TODO: use country code model
  final List<String> mobileCountryEnabled = <String>['TH'].obs;

  final Rx<PhoneNumber> phoneNumber = PhoneNumber(isoCode: 'TH').obs;

  // We need to declare iso variable here as a workaround to avoid bug in library
  // which revert the country selected back to initial value if we put
  // value directly in build() function (hash cache related)
  final PhoneNumber? initialPhoneNumber = PhoneNumber(isoCode: 'TH');

  final CountryCodeModel initialCountryCode = CountryCodeModel(
    name: 'Thailand',
    dial_code: '+66',
    code: 'TH',
  );

  final phoneNumberController = TextEditingController();

  final focusNodePhoneNumber = FocusNode();

  final isPhoneNumberValid = false.obs;

  @override
  void onInit() async {
    try {
      final info = await getEnabledCountryListUseCase.call(NoParams());
      mobileCountryEnabled.addAll(info.countryEnabled.reversed);
    } on ApiException catch (e, stackTrace) {
      _log.e('On SettingAccountPhoneNumberController init error.', e, stackTrace);

      if (e.code == 503) {
        if (e.message == 'ERR_SERVICE_ON_MAINTENANCE_MODE') {
          Get.dialog(
            MaintenanceDialog(
              isAnnouncement: false,
              maintenanceText: AppController.instance.maintenanceError(e.data?.getMessageData(
                AnnouncementController.instance.lang.toUpperCase(),
              )),
            ),
          );
        }
      }

      rethrow;
    } catch (e, stackTrace) {
      _log.e('Unexpected error on SettingAccountPhoneNumberController init.', e, stackTrace);
    }

    super.onInit();
  }

  @override
  void onClose() {
    focusNodePhoneNumber.unfocus();
    focusNodePhoneNumber.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }

  void onInputChanged(PhoneNumber number) {
    phoneNumber(number);
  }

  void onClearInputText() {
    phoneNumber(initialPhoneNumber!);
    phoneNumberController.clear();
    isPhoneNumberValid(false);
  }

  void onInputValidated(bool value) {
    isPhoneNumberValid(value);
  }
}
