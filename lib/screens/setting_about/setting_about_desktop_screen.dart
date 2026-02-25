import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

class SettingAboutAppDesktopScreen extends GetView<AppSettingsController> {
  const SettingAboutAppDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ScaffoldBasic(
        appBar: buildSettingAppBar(
          centerTitle: true,
          title: 'About UCHAT'.tr,
        ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 31.spMin,
                  vertical: 20.spMin,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SettingSpacer(),
                    UChatRowMenu(
                      title: 'Version'.tr,
                      suffixText: controller.version.toString(),
                      suffixTextStyle: TextStyle(
                        color: UTheme.color.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      showArrow: false,
                      hasVerticalBorder: true,
                      hasHorizontalBorder: true,
                      borderRadiusTop: true,
                    ),
                    UChatRowMenu(
                      hasTopBorder: false,
                      title: 'Build'.tr,
                      suffixText: controller.buildNumber.toString(),
                      suffixTextStyle: TextStyle(
                        color: UTheme.color.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      showArrow: false,
                      hasBottomBorder: true,
                      hasHorizontalBorder: true,
                      borderRadiusBottom: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
