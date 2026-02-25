import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/use_cases/get_enabled_country_list_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/login/login_with_phone_number_controller.dart';
import 'package:uchat/features/setting/domain/use_cases/check_new_phone_number_use_case.dart';
import 'package:uchat/features/setting/domain/use_cases/update_phone_number_use_case.dart';
import 'package:uchat/features/setting/presentation/controllers/setting_account_phone_number_change_controller.dart';
import 'package:uchat/widgets/input/phone_number_input_uchat_controller.dart';

class SettingAccountPhoneNumberChangeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PhoneNumberInputUChatController>(
      PhoneNumberInputUChatController(
        getEnabledCountryListUseCase: GetIt.I<GetEnabledCountryListUseCase>(),
      ),
      tag: 'login',
    );
    Get.put<LoginWithPhoneNumberController>(
      LoginWithPhoneNumberController(
        args: Get.arguments,
      ),
    );
    Get.put<SettingAccountPhoneNumberChangeController>(
      SettingAccountPhoneNumberChangeController(
        checkNewPhoneNumberUseCase: GetIt.I<CheckNewPhoneNumberUseCase>(),
        updatePhoneNumberUseCase: GetIt.I<UpdatePhoneNumberUseCase>(),
      ),
    );
  }
}
