import 'package:get/get.dart';
import 'package:uchat/features/auth/domain/factories/update_new_password_usecase_factory.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_password/setting_account_confirm_new_password_controller.dart';

class SettingAccountConfirmNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingAccountConfirmNewPasswordController(
        args: Get.arguments,
        updatePasswordUseCase: UpdateNewPasswordUseCaseFactory.create(Get.arguments.actionType),
      ),
    );
  }
}
