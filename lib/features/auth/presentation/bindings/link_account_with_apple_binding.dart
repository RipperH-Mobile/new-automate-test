import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_apple_controller.dart';

class LinkAccountWithAppleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LinkAccountWithAppleController>(
      LinkAccountWithAppleController(
        args: Get.arguments,
      ),
    );
  }
}
