import 'package:get/get.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_search_controller.dart';

class AddContactSearchBinding implements Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as String?;
    Get.put<AddContactSearchController>(AddContactSearchController(initialSearchKeyword: args));
  }
}
