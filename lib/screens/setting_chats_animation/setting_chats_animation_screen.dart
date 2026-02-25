import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_chats_preview_animation_and_sound/setting_chat_preview_animation_and_sound_screen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app/app_bar_leading_actions_text.dart';

import 'setting_chats_animation_controller.dart';

class SettingChatsAnimationScreen extends GetView<SettingChatsAnimationController> {
  const SettingChatsAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      child: CustomScrollView(
        slivers: [
          AppBarLeadingActionsText(
            titleText: 'Chat Animation setting'.tr,
            actionText: 'Complete'.tr,
            onActionPressed: controller.handleComplete,
            onLeadingPressed: controller.handleBack,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: PreviewAnimationAndSoundScreen(
                    type: PreviewAnimationAndSoundType.animation,
                    initialConfig: ConfigMessageInitial(
                      newMessageAnimatedDuration: controller.newMessageAnimatedDuration().toDouble(),
                      newMessageAnimatedType: controller.newMessageAnimatedType(),
                    ),
                    configResult: (config) {
                      if (config.newMessageAnimatedDuration != null) {
                        controller.newMessageAnimatedDuration(
                          config.newMessageAnimatedDuration!.toInt(),
                        );
                      }
                      if (config.newMessageAnimatedType != null) {
                        controller.newMessageAnimatedType(
                          config.newMessageAnimatedType!,
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
