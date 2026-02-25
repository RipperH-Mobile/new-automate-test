import 'package:get/get.dart';
import 'package:uchat/features/contact/presentation/controllers/contacts_search_screen_controller.dart';

class ContactsSearchScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ContactsSearchScreenController>(ContactsSearchScreenController());
  }
}
