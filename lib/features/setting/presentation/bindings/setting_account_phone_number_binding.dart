import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/setting/domain/use_cases/check_can_change_phone_number_use_case.dart';
import 'package:uchat/features/setting/presentation/controllers/setting_account_phone_number_controller.dart';

class SettingAccountPhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountPhoneNumberController>(
      SettingAccountPhoneNumberController(
        checkPasswordRequiredUseCase: GetIt.I<CheckPasswordRequiredUseCase>(),
        checkCanChangePhoneNumberUseCase: GetIt.I<CheckCanChangePhoneNumberUseCase>(),
      ),
    );
  }
}
