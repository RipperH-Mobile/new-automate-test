import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/screens/setting_chats_preview_animation_and_sound/setting_chat_preview_animation_and_sound_screen.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';

import 'setting_chats_controller.dart';

class SettingChatsScreen extends GetView<SettingChatsController> {
  const SettingChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return ScaffoldBasic(
      appBar: buildSettingAppBar(centerTitle: !isMobile, title: 'Chat'.tr),
      child: Container(
        margin: !isMobile
            ? EdgeInsets.symmetric(
                horizontal: 31.spMin,
                vertical: 20.spMin,
              )
            : null,
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Obx(() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SettingSpacer(),
                    if (!isMobile) ...[
                      Row(
                        children: [
                          Text(
                            'Folder for downloading files'.tr,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4D4D4D),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.spMin,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return Text(
                                    controller.saveDirectoryPath(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF808080),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.spMin,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: controller.handleSettingSaveDirectory,
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(0),
                              backgroundColor: WidgetStateProperty.all(Colors.white),
                              overlayColor: WidgetStateProperty.all(
                                const Color(0xFFE5E5E5).withValues(alpha: .5),
                              ),
                              padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(
                                  vertical: 20.spMin,
                                  horizontal: 30.spMin,
                                ),
                              ),
                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  side: const BorderSide(color: Color(0xFFE6E6E6)),
                                  borderRadius: BorderRadius.circular(10.spMin),
                                ),
                              ),
                            ),
                            child: Text(
                              'Edit folder'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: UTheme.color.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    SettingSpacer(
                      height: isMobile ? 0 : 28.spMin,
                    ),
                    UChatRowMenu(
                      title: 'Hidden chats'.tr,
                      onTap: () => controller.handleHiddenChats(),
                      hasVerticalBorder: true,
                      hasHorizontalBorder: !isMobile,
                      borderRadius: !isMobile ? 10 : 0,
                    ),
                    if (UserController.instance.enableNewMessageSound) settingNewMsgSound(),
                    if (UserController.instance.enableNewMessageAnimation && kDebugMode) settingNewMsgAnimation(),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  //TODO Move to sound screen
  Widget settingNewMsgSound() {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return Column(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: UChatSwitchRowMenu(
                title: 'Enable sound'.tr,
                subTitle: 'when send or receive a new message.'.tr,
                value: controller.isNewMsgSoundEnable(),
                onTap: controller.toggleNewMsgSoundEnable,
                hasVerticalBorder: true,
                hasHorizontalBorder: !isMobile,
                borderRadius: !isMobile
                    ? controller.isNewMsgSoundEnable()
                        ? 0
                        : 10
                    : 0,
                borderRadiusTop: !isMobile ? controller.isNewMsgSoundEnable() : false,
              ),
            ),
          ],
        ),
        if (controller.isNewMsgSoundEnable()) ...[
          UChatRowMenu(
            title: 'Sending sound (me): @sound'
                .trParams({'sound': (controller.newMessageSoundMeSelected()).replaceAll('audios/message/', '')}),
            onTap: () => controller.handleSoundSetting(isMe: true),
            hasBottomBorder: true,
            hasHorizontalBorder: !isMobile,
          ),
          UChatRowMenu(
            title: 'Receiving sound (friend): @sound'
                .trParams({'sound': (controller.newMessageSoundFriendSelected()).replaceAll('audios/message/', '')}),
            onTap: () => controller.handleSoundSetting(isMe: false),
            hasBottomBorder: true,
            hasHorizontalBorder: !isMobile,
          ),
          UChatRowMenu(
            title: 'Reset'.tr,
            onTap: () => controller.handleResetNewMsgSound(),
            showArrow: false,
            hasBottomBorder: true,
            hasHorizontalBorder: !isMobile,
            borderRadiusBottom: !isMobile,
          )
        ]
      ],
    );
  }

  //TODO Move to animation screen
  Widget settingNewMsgAnimation() {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return Column(
      children: [
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: UChatSwitchRowMenu(
                height: 80.spMin,
                title: 'Enable animation'.tr,
                subTitle: 'when send or receive a new message.'.tr,
                value: controller.isNewMsgAnimatedEnable(),
                onTap: controller.toggleNewMsgAnimatedEnable,
                hasVerticalBorder: true,
                hasHorizontalBorder: !isMobile,
                borderRadius: !isMobile
                    ? controller.isNewMsgAnimatedEnable()
                        ? 0
                        : 10
                    : 0,
                borderRadiusTop: !isMobile ? controller.isNewMsgAnimatedEnable() : false,
              ),
            ),
          ],
        ),
        if (controller.isNewMsgAnimatedEnable()) ...[
          UChatRowMenu(
            title: 'Animation type: @animation'
                .trParams({'animation': curves[controller.newMessageAnimatedType()].runtimeType.toString()}),
            onTap: () => controller.handleAnimationSetting(),
            hasBottomBorder: true,
            hasHorizontalBorder: !isMobile,
          ),
          UChatRowMenu(
            title: 'Animation speed: @duration second'
                .trParams({'duration': (controller.newMessageAnimatedDuration() / 1000).toString()}),
            onTap: () => controller.handleAnimationSetting(),
            hasBottomBorder: true,
            hasHorizontalBorder: !isMobile,
          ),
          UChatRowMenu(
            title: 'Reset'.tr,
            onTap: () => controller.handleResetNewMsgAnimation(),
            showArrow: false,
            hasBottomBorder: true,
            hasHorizontalBorder: !isMobile,
            borderRadiusBottom: !isMobile,
          )
        ],
      ],
    );
  }
}
