import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_chats_preview_animation_and_sound/setting_chat_preview_animation_and_sound_screen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app/app_bar_leading_actions_text.dart';

import 'setting_chats_sound_controller.dart';

class SettingChatsSoundScreen extends GetView<SettingChatsSoundController> {
  const SettingChatsSoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      child: CustomScrollView(
        slivers: [
          AppBarLeadingActionsText(
            titleText: 'Chat sound setting'.tr,
            actionText: 'Complete'.tr,
            onActionPressed: controller.handleComplete,
            onLeadingPressed: controller.handleBack,
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: PreviewAnimationAndSoundScreen(
                    type: PreviewAnimationAndSoundType.sound,
                    initialConfig: ConfigMessageInitial(
                      isMe: controller.isMe,
                      newMessageSoundFriendSelected: controller.newMessageSoundFriendSelected(),
                      newMessageSoundMeSelected: controller.newMessageSoundMeSelected(),
                    ),
                    configResult: (config) {
                      if (config.newMessageSoundFriendSelected != null) {
                        controller.newMessageSoundFriendSelected(
                          config.newMessageSoundFriendSelected,
                        );
                      }
                      if (config.newMessageSoundMeSelected != null) {
                        controller.newMessageSoundMeSelected(
                          config.newMessageSoundMeSelected,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
