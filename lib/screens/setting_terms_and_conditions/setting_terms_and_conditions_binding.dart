import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/screens/setting_terms_and_conditions/setting_terms_and_conditions_controller.dart';

class SettingTermsAndConditionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SettingTermsAndConditionsController(
        log: GetIt.I<LoggerService>(),
      ),
    );
  }
}
