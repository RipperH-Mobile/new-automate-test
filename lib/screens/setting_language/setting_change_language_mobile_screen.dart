import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/lang/lang.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

import 'setting_change_language_controller.dart';

class SettingChangeLanguageMobileScreen extends GetView<SettingChangeLanguageController> {
  const SettingChangeLanguageMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Change Language'.tr,
        leadingButton: AppControlButton.back(context: context),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
        ),
        child: Obx(
          () {
            return SettingFrameContainer.withChildren(
              context: context,
              children: List.generate(
                supportLocales.length,
                (index) => createLangMenu(
                  locale: supportLocales[index],
                  index: index,
                  lastIndex: supportLocales.length - 1,
                  context: context,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget createLangMenu({
    required BuildContext context,
    required Locale locale,
    required int index,
    required int lastIndex,
  }) {
    return UChatRowMenu(
      title: getTitle(locale),
      titleTextStyle: context.theme.appTexts.body1.copyWith(
        color: context.theme.appColors.textDarkest,
      ),
      showArrow: false,
      suffixWidget: controller.currentLocaleTag() == locale.toLanguageTag()
          ? Icon(
              Icons.check,
              size: AppSize.size4,
              color: context.theme.appColors.iconSelected,
            )
          : null,
      onTap: () => controller.changeLocale(locale),
      hasBorder: false,
      padding: const EdgeInsets.only(
        left: AppSpace.space4,
        right: AppSpace.space3,
        top: AppSpace.space3,
        bottom: AppSpace.space3,
      ),
    );
  }
}
