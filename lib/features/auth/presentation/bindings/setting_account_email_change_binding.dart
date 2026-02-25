import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/update_email_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_new_email_setting_account_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_email/setting_account_email_change_controller.dart';

class SettingAccountEmailChangeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountEmailChangeController>(
      SettingAccountEmailChangeController(
        validateNewEmailSettingAccountUseCase: GetIt.I<ValidateNewEmailSettingAccountUseCase>(),
        updateEmailSettingAccountUseCase: GetIt.I<UpdateEmailSettingAccountUseCase>(),
        arguments: Get.arguments,
      ),
    );
  }
}
