import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_apple_id/setting_account_update_apple_id_syncing_controller.dart';

class SettingAccountUpdateAppleIdSyncingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountUpdateAppleIdSyncingController>(
      SettingAccountUpdateAppleIdSyncingController(
        checkPasswordRequiredUseCase: GetIt.I<CheckPasswordRequiredUseCase>(),
      ),
    );
  }
}
