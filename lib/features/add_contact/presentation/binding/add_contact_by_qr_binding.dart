import 'package:get/get.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_by_qr_controller.dart';

class AddContactByQrBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AddContactByQrController>(AddContactByQrController());
  }
}
