import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_email_controller.dart';

class LinkAccountWithEmailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LinkAccountWithEmailController>(
      LinkAccountWithEmailController(
        args: Get.arguments,
      ),
    );
  }
}
