import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_facebook_controller.dart';

class LinkAccountWithFacebookBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LinkAccountWithFacebookController>(
      LinkAccountWithFacebookController(
        args: Get.arguments,
      ),
    );
  }
}
