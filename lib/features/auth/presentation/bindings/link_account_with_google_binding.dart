import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_google_controller.dart';

class LinkAccountWithGoogleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LinkAccountWithGoogleController>(
      LinkAccountWithGoogleController(
        args: Get.arguments,
      ),
    );
  }
}
