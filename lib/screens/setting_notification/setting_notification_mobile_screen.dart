import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/banner/banner_notification.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class SettingNotificationMobileScreen extends GetView<SettingNotificationController> {
  const SettingNotificationMobileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.surfaceDark,
      appBar: AppBarDefault(
        title: 'Notification'.tr,
        leadingButton: AppControlButton.back(context: context),
      ),
      child: Column(
        children: [
          GetBuilder<SettingNotificationController>(
            id: SettingNotificationBId.notificationPermissionBanner,
            builder: (ctl) {
              if (!ctl.notificationNativePermission) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BannerNotification(
                      bgColor: context.theme.appColors.surfaceDark,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.space4,
                        vertical: AppSpace.space1,
                      ),
                      onPressed: () => controller.requestNotificationNativePermission(),
                    ),
                    const SizedBox(height: AppSpace.space3),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
            ),
            child: Obx(
              () {
                return SettingFrameContainer.withChildren(
                  context: context,
                  children: [
                    UChatSwitchRowMenu(
                      title: 'Enable Notification'.tr,
                      value: controller.isAllowNotification.value,
                      onTap: (value) {
                        controller.updateNotificationSettings(
                          enabled: value,
                          hiddenMessage: controller.isShowMessage.value,
                        );
                      },
                      hasBorder: false,
                      padding: const EdgeInsets.only(
                        left: AppSpace.space4,
                        right: AppSpace.space3,
                        top: AppSpace.space3,
                        bottom: AppSpace.space3,
                      ),
                    ),
                    UChatSwitchRowMenu(
                      title: 'Hide message when notify'.tr,
                      value: controller.isShowMessage.value,
                      onTap: (value) {
                        controller.updateNotificationSettings(
                          hiddenMessage: value,
                          enabled: controller.isAllowNotification.value,
                        );
                      },
                      hasBorder: false,
                      padding: const EdgeInsets.only(
                        left: AppSpace.space4,
                        right: AppSpace.space3,
                        top: AppSpace.space3,
                        bottom: AppSpace.space3,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
