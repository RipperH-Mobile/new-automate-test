import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_email/setting_account_email_v2_controller.dart';

class SettingAccountEmailV2Binding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountEmailV2Controller>(
      SettingAccountEmailV2Controller(
        checkPasswordRequiredUseCase: GetIt.I<CheckPasswordRequiredUseCase>(),
      ),
    );
  }
}
