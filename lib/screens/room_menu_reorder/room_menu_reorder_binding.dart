import 'package:get/get.dart';

import 'room_menu_reorder_controller.dart';

class RoomMenuReorderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RoomMenuReorderController>(RoomMenuReorderController());
  }
}
