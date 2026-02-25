import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_google_account/setting_account_update_google_account_syncing_controller.dart';

class SettingAccountUpdateGoogleAccountSyncingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountUpdateGoogleAccountSyncingController>(
      SettingAccountUpdateGoogleAccountSyncingController(
        checkPasswordRequiredUseCase: GetIt.I<CheckPasswordRequiredUseCase>(),
      ),
    );
  }
}
