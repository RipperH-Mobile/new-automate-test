import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_folder_controller.dart';
import 'chat_folder_list.dart';
import 'chat_folder_tab_bar_view.dart';

class ChatFolderBody extends GetWidget<ChatFolderController> {
  const ChatFolderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isAllowManageFolder.value) {
          return const ChatFolderTabBarView();
        }

        return ChatFolderList(folder: controller.chatFolders.first, index: 0);
      },
    );
  }
}
