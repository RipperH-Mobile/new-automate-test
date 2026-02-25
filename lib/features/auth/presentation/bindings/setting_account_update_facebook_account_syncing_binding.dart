import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_facebook_account/setting_account_update_facebook_account_syncing_controller.dart';

class SettingAccountUpdateFacebookAccountSyncingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingAccountUpdateFacebookAccountSyncingController>(
      SettingAccountUpdateFacebookAccountSyncingController(
        checkPasswordRequiredUseCase: GetIt.I<CheckPasswordRequiredUseCase>(),
      ),
    );
  }
}
