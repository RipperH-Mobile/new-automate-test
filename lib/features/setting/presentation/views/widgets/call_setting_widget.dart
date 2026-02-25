import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/screens/setting_call/setting_call_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class CallSetting extends GetView<SettingCallController> {
  const CallSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Call setting'.tr,
        context: context,
        color: context.theme.appColors.textDark,
      ),
      children: [
        Obx(
          () {
            return UChatSwitchRowMenu(
              title: 'Allow incoming call'.tr,
              value: controller.isAllowIncomingCall.value,
              onTap: controller.toggleAllowIncomingCall,
              hasBorder: false,
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
                right: AppSpace.space3,
                top: AppSpace.space3,
                bottom: AppSpace.space3,
              ),
              titleTextStyle: context.theme.appTexts.body1.copyWith(
                color: context.theme.appColors.textDarkest,
              ),
            );
          },
        ),
        Obx(
          () {
            final type = Platform.isIOS ? 'iPhone'.tr : 'call\'s system'.tr;

            return UChatSwitchRowMenu(
              title: 'Make a call with @type'.trParams({'type': type}),
              subTitle: 'Call from @type and show call history With @type.'.trParams({'type': type}),
              value: controller.isAllowCallkit.value,
              onTap: controller.toggleAllowCallkit,
              hasBorder: false,
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
                right: AppSpace.space3,
                top: AppSpace.space3,
                bottom: AppSpace.space3,
              ),
              titleTextStyle: context.theme.appTexts.body1.copyWith(
                color: context.theme.appColors.textDarkest,
              ),
              subTitleTextStyle: context.theme.appTexts.body4.copyWith(
                color: context.theme.appColors.textLight,
              ),
            );
          },
        ),
      ],
    );
  }
}
