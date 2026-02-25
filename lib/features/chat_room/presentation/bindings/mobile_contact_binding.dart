import 'package:get/get.dart';
import 'package:uchat/features/chat_room/presentation/controllers/mobile_contact_list_screen_controller.dart';

class MobileContactBinding implements Bindings {
  @override
  void dependencies() {
    final tag = Get.parameters['id'] ?? 'NEW_ROOM';
    Get.put<MobileContactListScreenController>(MobileContactListScreenController(tag: tag));
  }
}
