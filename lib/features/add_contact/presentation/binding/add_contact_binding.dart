import 'package:get/get.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_controller.dart';

class AddContactBinding implements Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AddContactController>()) {
      Get.put<AddContactController>(AddContactController());
    }
  }
}
