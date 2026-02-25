import 'package:get/get.dart';
import 'package:uchat/features/auth/domain/factories/validate_new_password_usecase_factory.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_password/setting_account_create_new_password_controller.dart';

class SettingAccountCreateNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingAccountCreateNewPasswordController(
        args: Get.arguments,
        validateNewPasswordUseCase: ValidateNewPasswordUseCaseFactory.create(Get.arguments.actionType),
      ),
    );
  }
}
