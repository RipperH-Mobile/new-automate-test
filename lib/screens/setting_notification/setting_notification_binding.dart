import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/update_account_setting_use_case.dart';
import 'setting_notification_controller.dart';

class SettingNotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingNotificationController>(
      () => SettingNotificationController(
        updateAccountSettingUseCase: GetIt.I<UpdateAccountSettingUseCase>(),
      ),
    );
  }
}
