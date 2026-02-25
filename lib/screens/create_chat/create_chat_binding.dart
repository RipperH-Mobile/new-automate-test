import 'package:get/get.dart';

import 'create_chat_controller.dart';

class CreateChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CreateChatController>(CreateChatController());
  }
}
