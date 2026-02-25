import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_folder/presentation/widgets/chat_folder_body.dart';

import '../controllers/chat_folder_controller.dart';
import '../widgets/chat_folder_header.dart';

class ChatFolderChatRoomListScreen extends StatelessWidget {
  final NestedScrollViewHeaderSliversBuilder headerSliverBuilder;
  final NestedScrollViewHeaderSliversBuilder? subHeaderSliverBuilder;

  const ChatFolderChatRoomListScreen({
    super.key,
    required this.headerSliverBuilder,
    this.subHeaderSliverBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatFolderController>(
      id: gbChatFolderDefaultTabController,
      builder: (chatFolderController) {
        return DefaultTabController(
          length: chatFolderController.chatFolders.length,
          child: NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              final parentHeaderSliverBuilder = headerSliverBuilder(context, innerBoxIsScrolled);
              List<Widget>? parentSubHeaderSliverBuilder = subHeaderSliverBuilder?.call(context, innerBoxIsScrolled);

              return [
                ...parentHeaderSliverBuilder,
                const ChatFolderHeader(),
                if (parentSubHeaderSliverBuilder != null) ...parentSubHeaderSliverBuilder,
              ];
            },
            body: const ChatFolderBody(),
          ),
        );
      },
    );
  }
}
