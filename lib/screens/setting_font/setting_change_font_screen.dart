import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/setting_font/setting_change_font_controller.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';

class SettingChangeFontScreen extends GetView<SettingChangeFontController> {
  const SettingChangeFontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = UChatScreenUtil.instance.isMobile;

    return ScaffoldBasic(
      appBar: buildSettingAppBar(
        centerTitle: !isMobile,
        title: 'Change Font'.tr,
      ),
      child: Column(
        children: [
          SizedBox(height: 15.spMin),
          // Change to another widget row menu
          // Obx(() {
          //   return RoomDetailRowMenu(
          //     title: 'Noto Sans Thai',
          //     isOpen: controller.fontTheme() == 'Noto' && controller.isChangedFont(),
          //     onTap: () => controller.handleChangeFont('Noto'),
          //   );
          // }),
          // Obx(() {
          //   return RoomDetailRowMenu(
          //     title: 'Noto Sans Thai Looped',
          //     isOpen: controller.fontTheme() == 'NotoLooped' && controller.isChangedFont(),
          //     onTap: () => controller.handleChangeFont('NotoLooped'),
          //     hasTopBorder: false,
          //   );
          // }),
          // Obx(() {
          //   return RoomDetailRowMenu(
          //     title: 'Bai Jamjuree',
          //     isOpen: controller.fontTheme() == 'BaiJamjuree' && controller.isChangedFont(),
          //     onTap: () => controller.handleChangeFont('BaiJamjuree'),
          //     hasTopBorder: false,
          //   );
          // }),
          SizedBox(height: 15.spMin),
        ],
      ),
    );
  }
}
