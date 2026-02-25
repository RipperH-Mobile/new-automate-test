import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

PreferredSizeWidget buildSettingAppBar({
  required String title,
  bool? centerTitle = false,
  Widget? leading,
  double? height,
  double? borderBottom,
}) {
  return AppBar(
    centerTitle: centerTitle,
    titleSpacing: 0,
    leadingWidth: leading != null ? 100 : null,
    toolbarHeight: height,
    leading: Padding(
      padding: const EdgeInsets.only(left: AppSpace.space4),
      child: AppControlButton.back(
        context: Get.context!,
        iconColor: Get.context!.theme.appColors.icon,
        showLabel: false,
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Color(0xFF333333),
      ),
    ),
    shape: Border(
      bottom: BorderSide(
        color: const Color(0xFFE6E6E6),
        width: borderBottom ?? 1,
      ),
    ),
    elevation: 0,
  );
}
