import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class ChatSettingWidget extends StatelessWidget {
  final void Function() onPress;

  const ChatSettingWidget({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpace.space4,
      children: [
        SettingFrameContainer.withChildren(
          context: context,
          header: AppText.body4Bold(
            'Chat setting'.tr,
            color: context.theme.appColors.textDark,
            context: context,
          ),
          children: [
            UChatRowMenu(
              title: 'Hidden chats'.tr,
              onTap: onPress,
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
            ),
          ],
        ),
      ],
    );
  }
}
