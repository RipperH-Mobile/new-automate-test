import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_password/setting_account_change_password_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/setting_menu_box.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SettingAccountChangePasswordScreen extends GetView<SettingAccountChangePasswordController> {
  const SettingAccountChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Password'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space6,
        ),
        child: Column(
          children: [
            SettingMeuBox.textWithArrow(
              context: context,
              text: 'Change to new password'.tr,
              onTap: controller.onContinue,
            ),
          ],
        ),
      ),
    );
  }
}
