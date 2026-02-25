import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class SettingAboutAppMobileScreen extends GetView<AppSettingsController> {
  const SettingAboutAppMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'About UChat'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
        ),
        child: SettingFrameContainer.withChildren(
          context: context,
          children: [
            UChatRowMenu(
              title: 'Version'.tr,
              suffixText: controller.version.toString(),
              suffixTextStyle: context.theme.appTexts.body1.copyWith(
                color: context.theme.appColors.textLighter,
              ),
              showArrow: false,
              hasBorder: false,
            ),
            UChatRowMenu(
              hasTopBorder: false,
              title: 'Build'.tr,
              suffixText: controller.buildNumber.toString(),
              suffixTextStyle: context.theme.appTexts.body1.copyWith(
                color: context.theme.appColors.textLighter,
              ),
              showArrow: false,
              hasBorder: false,
            ),
          ],
        ),
      ),
    );
  }
}
