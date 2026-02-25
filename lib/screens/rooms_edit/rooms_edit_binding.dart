import 'package:get/get.dart';

import 'rooms_edit_controller.dart';

class RoomsEditBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<RoomsEditController>(RoomsEditController());
  }
}
