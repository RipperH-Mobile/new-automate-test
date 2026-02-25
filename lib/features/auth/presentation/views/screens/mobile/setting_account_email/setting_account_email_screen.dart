import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/setting_account_email/setting_account_email_v2_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/setting_menu_box.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class SettingAccountEmailScreenV2 extends GetView<SettingAccountEmailV2Controller> {
  const SettingAccountEmailScreenV2({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Email'.tr,
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
            SettingMeuBox(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.body3(
                      'Registered'.tr,
                      context: context,
                      color: context.theme.appColors.textLight,
                    ),
                    const SizedBox(
                      height: AppSpace.space1,
                    ),
                    AppText.body1(
                      controller.email.value,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSpace.space4,
            ),
            SettingMeuBox.textWithArrow(
              context: context,
              text: 'Change to new email'.tr,
              onTap: () {
                controller.onContinue(isChangeEmail: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
