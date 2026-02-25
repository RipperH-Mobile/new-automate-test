import 'package:get/get.dart';

import '../controllers/chat_folder_create_controller.dart';

class ChatFolderCreateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatFolderCreateController>(() => ChatFolderCreateController());
  }
}
