import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/logout/logout_controller.dart';

class LogoutBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LogoutController>(LogoutController());
  }
}
