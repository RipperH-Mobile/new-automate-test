import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_folder/presentation/controllers/chat_folder_controller.dart';
import 'package:uchat/features/chat_folder/presentation/widgets/chat_folder_header_tab_bar.dart';
import 'package:uchat/widgets/sliver/sliver_to_box_persistent_header.dart';

class ChatFolderHeader extends GetWidget<ChatFolderController> {
  const ChatFolderHeader({super.key});

  double get chatFolderHeaderTabBarHeight {
    return controller.isEnabled ? AppSpace.space8 : AppSpace.space0;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isAllowManageFolder.value) {
          return SliverToBoxPersistentHeader(
            scrollBehaviour: SliverToBoxPersistentHeaderBehaviour.pinned,
            child: Transform.translate(
              offset: Offset(0, GetPlatform.isAndroid ? -2 : AppSpace.space0),
              child: Container(
                color: context.theme.appColors.backgroundNeutralLighter,
                height: chatFolderHeaderTabBarHeight,
                child: Stack(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: AppSpace.space4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ChatFolderHeaderTabBar(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Divider(
                        height: 1,
                        color: context.theme.appColors.border,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }
      },
    );
  }
}
