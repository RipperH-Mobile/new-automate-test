import 'package:get/get.dart';

import '../controllers/chat_folder_edit_detail_controller.dart';

class ChatFolderEditDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatFolderEditDetailController>(() => ChatFolderEditDetailController(), tag: Get.parameters['id']);
  }
}
