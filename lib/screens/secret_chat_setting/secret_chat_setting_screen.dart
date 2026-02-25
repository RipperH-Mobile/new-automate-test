import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/secret_chat_setting/secret_chat_setting_controller.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/extension/extension_number.dart';

import 'package:uchat/widgets.dart';

class SecretChatSettingScreen extends GetView<SecretChatSettingController> {
  const SecretChatSettingScreen({super.key});

  @override
  String? get tag => Get.parameters['id'];

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBar(
        iconTheme: IconThemeData(color: UTheme.color.secretRoomText),
        backgroundColor: UTheme.color.secretRoomSettingBlueAccent,
        title: Row(
          children: [
            Text(
              'Secret chat setting'.tr,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: UTheme.color.secretRoomText,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                'assets/images/lock_icon_yellow.png',
              ),
            ),
          ],
        ),
      ),
      backgroundColor: UTheme.color.secretRoomChatBlueHeader,
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        ...buildMenu(context),
      ],
    );
  }

  List<Widget> buildMenu(BuildContext context) {
    return [
      SizedBox(height: 24.spMin),
      _buildSettingTitle('Notification setting'.tr),
      SizedBox(height: 12.spMin),
      Obx(() {
        return UChatSwitchRowMenu(
          title: 'Turn off message notifications'.tr,
          value: controller.isTurnOffMessageNotifications.value,
          onTap: (value) => controller.handleToggleTurnOffMessageNotifications(value ?? false),
          backgroundColor: UTheme.color.secretRoomSettingBlueAccent,
          titleTextStyle: const TextStyle(color: Colors.white),
          thumbColor: controller.isTurnOffMessageNotifications.value ? null : const Color(0xFF123772),
          trackColor: UTheme.color.secretRoomButtonBlackColor,
          borderColor: UTheme.color.secretRoomDivider,
          hasVerticalBorder: controller.isMobile,
        );
      }),
      Obx(() {
        return Opacity(
          opacity: controller.isTurnOffMessageNotifications() ? 0.5 : 1,
          child: UChatSwitchRowMenu(
            title: 'Hide message notifications details'.tr,
            value: controller.isHideMessageNotifications.value,
            onTap: (value) => controller.handleToggleHideMessageNotifications(value ?? false),
            backgroundColor: UTheme.color.secretRoomSettingBlueAccent,
            titleTextStyle: const TextStyle(color: Colors.white),
            thumbColor: controller.isHideMessageNotifications.value ? null : const Color(0xFF123772),
            trackColor: UTheme.color.secretRoomButtonBlackColor,
            borderColor: UTheme.color.secretRoomDivider,
            hasBottomBorder: true,
          ),
        );
      }),
      SizedBox(height: 24.spMin),
      _buildSettingTitle('Secret chat duration setting'.tr),
      SizedBox(height: 12.spMin),
      Obx(() {
        return UChatSwitchRowMenu(
          title: 'Show expired date'.tr,
          value: true,
          onTap: (_) {},
          // TODO: NO more `lessThanThreeMins` in `roomCtl` check when this feat is implemented.
          // value: (controller.roomCtl!.lessThanThreeMins.value) ? true : controller.isShowExpireTime.value,
          // onTap: (value) => (controller.roomCtl!.lessThanThreeMins.value)
          //     ? null
          //     : controller.handleToggleShowExpireTime(value ?? false),
          backgroundColor: UTheme.color.secretRoomSettingBlueAccent,
          titleTextStyle: const TextStyle(color: Colors.white),
          thumbColor: controller.isShowExpireTime.value ? null : const Color(0xFF123772),
          trackColor: UTheme.color.secretRoomButtonBlackColor,
          borderColor: UTheme.color.secretRoomDivider,
          hasTopBorder: true,
        );
      }),
      Obx(
        () => UChatRowMenu(
          title: 'Secret chat duration'.tr,
          titleTextStyle: const TextStyle(color: Colors.white),
          onTap: () => controller.handleSecretChatDurationPressed(),
          suffixText: Duration(seconds: controller.roomCtl?.room()?.expireIn ?? 0).durationTextWithUnit,
          suffixTextStyle: TextStyle(color: UTheme.color.secretRoomTextBlue, fontSize: 16),
          arrowColor: UTheme.color.secretRoomTextBlue,
          backgroundColor: UTheme.color.secretRoomSettingBlueAccent,
          borderColor: UTheme.color.secretRoomDivider,
          hasVerticalBorder: controller.isMobile,
        ),
      ),
      SizedBox(height: 20.spMin),
      UChatRowMenu(
        prefixWidget: Image.asset(
          'assets/images/remove_rectangle_icon.png',
          cacheWidth: 50.cacheSize,
        ),
        title: 'End this secret chat'.tr,
        titleTextStyle: const TextStyle(color: Colors.white),
        onTap: () => controller.handleEndSecretChat(),
        backgroundColor: UTheme.color.secretRoomSettingBlueAccent,
        borderColor: UTheme.color.secretRoomDivider,
        showArrow: false,
        hasVerticalBorder: controller.isMobile,
      ),
    ];
  }

  Widget _buildSettingTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 20.spMin),
        child: Text(
          title,
          style: TextStyle(color: UTheme.color.secretRoomHeaderText),
        ),
      ),
    );
  }
}
