import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_folder/presentation/widgets/chat_folder_list.dart';

import '../controllers/chat_folder_controller.dart';

class ChatFolderTabBarView extends StatelessWidget {
  const ChatFolderTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatFolderController>(
      id: gbChatFolderTabBarView,
      builder: (chatFolderController) {
        return TabBarView(
          children: List.generate(
            chatFolderController.chatFolders.length,
            (index) {
              final chatFolder = chatFolderController.chatFolders.elementAtOrNull(index);
              if (chatFolder == null) {
                return const SizedBox.shrink();
              }

              return ChatFolderList(folder: chatFolder, index: index);
            },
          ),
        );
      },
    );
  }
}
