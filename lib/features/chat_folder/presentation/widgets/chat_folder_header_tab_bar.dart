import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/themes/util.dart';

import '../controllers/chat_folder_controller.dart';

class ChatFolderHeaderTabBar extends StatelessWidget {
  const ChatFolderHeaderTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatFolderController>(
      id: gbChatFolderTabBar,
      builder: (chatFolderController) {
        return TabBar(
          isScrollable: true,
          onTap: chatFolderController.onTapOnTabBar,
          labelColor: context.theme.appColors.textDarkest,
          indicatorColor: context.theme.appColors.textDarkest,
          indicatorSize: TabBarIndicatorSize.label,
          labelPadding: const EdgeInsets.only(right: AppSpace.space4),
          unselectedLabelColor: context.theme.appColors.textLighter,
          indicatorWeight: 1.5,
          tabs: List.generate(
            chatFolderController.chatFolders.length,
            (index) {
              final chatFolder = chatFolderController.chatFolders.elementAtOrNull(index);

              // NOTE: [ChatFolder] Use GetBuilder instead of Obx to avoid rebuild the whole tab bar
              // when the unread count changes
              return GetBuilder<ChatFolderController>(
                  id: '$gbChatFolderTabBarItemPrefix${chatFolder?.id ?? 'other'}',
                  builder: (chatFolderController) {
                    final chatFolder = chatFolderController.chatFolders.elementAtOrNull(index);

                    if (chatFolder == null) {
                      return const SizedBox.shrink();
                    }

                    return Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Get.height * 0.05),
                          height: AppSpace.spacePx,
                          color: context.theme.appColors.borderDisable,
                        ),
                        Tab(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: chatFolder.isUnread == true ? AppSpace.space015 : AppSpace.space0),
                            child: Text(
                              chatFolder.displayName,
                              style: context.theme.appTexts.button2Bold,
                            ),
                          ),
                        ),
                        if (chatFolder.isUnread == true)
                          Positioned(
                            top: AppSpace.space05,
                            right: AppSpace.space0,
                            child: Container(
                              width: AppSpace.space015,
                              height: AppSpace.space015,
                              decoration: BoxDecoration(
                                color: UTheme.color.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    );
                  });
            },
          ),
        );
      },
    );
  }
}
