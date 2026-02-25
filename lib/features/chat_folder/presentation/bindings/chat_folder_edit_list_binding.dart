import 'package:get/get.dart';

import '../controllers/chat_folder_edit_list_controller.dart';

class ChatFolderEditListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatFolderEditListController>(() => ChatFolderEditListController());
  }
}
