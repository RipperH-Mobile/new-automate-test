import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/app_env.dart';

class AppVersion extends GetView<AppSettingsController> {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextButton(
        onPressed: () => controller.handleTapBuildVersion(),
        style: TextButton.styleFrom(padding: const EdgeInsets.all(8)),
        child: Column(
          children: [
            Text(
              'UChat Messenger'.tr,
              style: UTheme.textTheme.settingAppVersion.copyWith(
                color: UTheme.color.settingAppVersion,
              ),
            ),
            Obx(
              () => Text(
                controller.versionString,
                style: UTheme.textTheme.settingAppVersionNumber.copyWith(
                  color: UTheme.color.settingAppVersion,
                ),
              ),
            ),
            if (!AppEnv.isProd)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '(In @env Mode)'.trParams({
                    'env': AppEnv.serverEnvType,
                  }),
                  style: UTheme.textTheme.settingAppVersionNumber.copyWith(
                    color: UTheme.color.settingAppVersion.withValues(alpha: 0.6),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
