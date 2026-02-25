import 'package:get/get.dart';
import 'package:uchat/screens/contact_selection/contact_selection_controller.dart';

class ContactSelectionBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';
    Get.put<ContactSelectionController>(ContactSelectionController(tag: tag), tag: tag);
  }
}
