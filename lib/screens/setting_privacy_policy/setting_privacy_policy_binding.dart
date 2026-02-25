import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/screens/setting_privacy_policy/setting_privacy_policy_controller.dart';

class SettingPrivacyPolicyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingPrivacyPolicyController(
        log: GetIt.I<LoggerService>(),
      ),
    );
  }
}
