import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/setting/presentation/views/widgets/call_setting_widget.dart';
import 'package:uchat/features/setting/presentation/views/widgets/chat_setting_widget.dart';
import 'package:uchat/features/setting/presentation/views/widgets/friend_setting_widget.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class SettingFriendChatCallScreen extends GetView<AppSettingsController> {
  const SettingFriendChatCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Friend Chat and Call'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: AppSpace.space4,
          right: AppSpace.space4,
          bottom: AppSpace.space6,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpace.space4,
          children: [
            const FriendSetting(),
            ChatSettingWidget(onPress: controller.handleChat),
            const CallSetting(),
          ],
        ),
      ),
    );
  }
}
