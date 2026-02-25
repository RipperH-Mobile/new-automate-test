import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension_asset_image.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';
import 'package:uchat/widgets/setting/setting_switch_row.dart';

class SettingsScreen extends GetView<AppSettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Setting'.tr,
        leadingButton: AppControlButton.back(context: context),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: AppSpace.space4,
          right: AppSpace.space4,
          top: AppSpace.space4,
          bottom: AppSpace.space6,
        ),
        child: Obx(
          () {
            return SafeArea(
              child: Column(
                spacing: AppSpace.space6,
                children: [
                  _generalSection(context),
                  _applicationInformationSection(context),
                  _developerToolsSection(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _generalSection(BuildContext context) {
    List<Widget> children = [
      SettingRow(
        assetIcon: Assets.images.v2.settingsNotification.toAssetImage(),
        title: 'Notification'.tr,
        onPressed: controller.handleNoti,
      ),
      SettingRow(
        assetIcon: Assets.images.v2.settingsLang.toAssetImage(),
        title: 'Change Language'.tr,
        onPressed: controller.handleChangeLanguage,
      ),
    ];
    if (controller.isOaUserInDb.value) {
      children.add(
        SettingRow(
          assetIcon: Assets.images.v2.helpCenter.toAssetImage(),
          title: 'Help Center'.tr,
          onPressed: controller.handleHelpCenter,
        ),
      );
    }
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'General'.tr,
        context: context,
        color: context.theme.appColors.textDark,
      ),
      children: children,
    );
  }

  Widget _applicationInformationSection(BuildContext context) {
    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Application Information'.tr,
        context: context,
        color: context.theme.appColors.textDark,
      ),
      children: [
        SettingRow(
          assetIcon: Assets.images.settingsPrivacyIcon.toAssetImage(),
          title: 'Privacy Policy'.tr,
          onPressed: controller.handlePrivacyPolicy,
        ),
        SettingRow(
          assetIcon: Assets.images.v2.settingsAgreement.toAssetImage(),
          title: 'Term and conditions of use'.tr,
          onPressed: controller.handleTerms,
        ),
        SettingRow(
          assetIcon: Assets.images.v2.settingsAboutApp.toAssetImage(),
          title: 'About UChat'.tr,
          onPressed: controller.handleAboutApp,
        ),
      ],
    );
  }

  Widget _developerToolsSection(BuildContext context) {
    if (!UserController.instance.enableTroubleshoot && !UserController.instance.enableTalker) {
      return const SizedBox.shrink();
    }

    return SettingFrameContainer.withChildren(
      context: context,
      header: AppText.body4Bold(
        'Developer tools'.tr,
        context: context,
        color: context.theme.appColors.textDark,
      ),
      children: [
        if (UserController.instance.enableTroubleshoot)
          SettingRow(
            iconLeft: Icons.help_outline_rounded,
            title: 'Troubleshoot'.tr,
            onPressed: controller.handleTroubleshoot,
          ),
        if (UserController.instance.enableTalker)
          SettingRow(
            iconLeft: Icons.monitor_heart_outlined,
            title: 'Talker'.tr,
            onPressed: controller.handleTalker,
          ),
        if (UserController.instance.enableTroubleshoot)
          Obx(
            () => SettingSwitchRow(
              title: 'Event Bus Tracking'.tr,
              value: controller.enableEventBusTracking.value,
              onTap: controller.toggleEnableEventBusTracking,
            ),
          ),
        if (UserController.instance.enableTroubleshoot)
          SettingRow(
            iconLeft: Icons.event_note,
            title: 'Event Monitor'.tr,
            onPressed: () => Get.toNamed('/troubleshoot/event_monitor'),
          ),
        if (UserController.instance.enableTroubleshoot)
          SettingRow(
            iconLeft: Icons.file_copy,
            title: 'Cache manager'.tr,
            onPressed: controller.handleCacheManager,
          ),
        if (UserController.instance.enableTroubleshoot)
          SettingRow(
            iconLeft: Icons.notifications_active,
            title: 'Notification Debugger'.tr,
            onPressed: controller.handleNotificationDebug,
          ),
      ],
    );
  }
}
