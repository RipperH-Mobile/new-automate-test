import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/lang/lang.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

import 'setting_change_language_controller.dart';

class SettingChangeLanguageDesktopScreen extends GetView<SettingChangeLanguageController> {
  const SettingChangeLanguageDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ScaffoldBasic(
        appBar: buildSettingAppBar(
          centerTitle: true,
          title: 'Change Language'.tr,
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
                    ...List.generate(
                      supportLocales.length,
                      (index) => createLangMenu(supportLocales[index], index, supportLocales.length - 1),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget createLangMenu(Locale locale, int index, int lastIndex) {
    return UChatRowMenu(
      title: getTitle(locale),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: controller.currentLocaleTag() != locale.toLanguageTag() ? FontWeight.w400 : FontWeight.w500,
        color: controller.currentLocaleTag() != locale.toLanguageTag() ? Colors.black : UTheme.color.primary,
      ),
      showArrow: false,
      suffixWidget: controller.currentLocaleTag() == locale.toLanguageTag()
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Icon(
                Icons.check,
                size: 17,
                color: UTheme.color.primary,
                // color: UTheme.color.settingItemSecondary,
              ),
            )
          : null,
      onTap: () => controller.changeLocale(locale),
      borderRadiusTop: index == 0,
      borderRadiusBottom: index == lastIndex,
      hasBottomBorder: index == lastIndex,
      hasTopBorder: true,
      hasHorizontalBorder: true,
    );
  }
}
