import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:popover/popover.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'widgets/pop_over_menu_item.dart';

class UChatPopover {
  static Future<T?> open<T extends Object?>({
    required BuildContext context,
    List<PopoverMenuItem> menu = const [],
    Widget? child,
    VoidCallback? onPop,
    PopoverDirection direction = PopoverDirection.bottom,
    PopoverTransition transition = PopoverTransition.scale,
    double contentDyOffset = 0,
    double contentDxOffset = 0,
    double? width,
    double? height,
    double? maxHeight,
    Color popupBackgroundColor = Colors.white,
    Widget Function(Animation<double> animation, Widget child)? popoverTransitionBuilder,
  }) async {
    return showPopover<T>(
      context: context,
      bodyBuilder: (popOverContext) {
        if (child != null) {
          return child;
        }

        return SingleChildScrollView(
          child: Column(
            children: menu,
          ),
        );
      },
      radius: 15.spMin,
      onPop: onPop,
      direction: direction,
      transition: transition,
      backgroundColor: popupBackgroundColor,
      barrierColor: Colors.transparent,
      width: width ?? 150.spMin,
      height: height,
      constraints: BoxConstraints(
        minWidth: 150.spMin,
        maxHeight: maxHeight ?? (Get.height - contentDyOffset - 80).spMin,
      ),
      // Cannot set arrowHeight to 0 - causes incorrect positioning
      // arrowHeight: 0,
      arrowWidth: 0,
      contentDyOffset: contentDyOffset,
      contentDxOffset: contentDxOffset,
      shadow: [
        BoxShadow(
          color: context.theme.appColors.icon.withValues(alpha: 0.25),
          blurRadius: 16,
          offset: const Offset(0, 2),
          spreadRadius: 0,
        ),
      ],
      popoverTransitionBuilder: popoverTransitionBuilder,
    );
  }

  static void openFileInfo({
    required BuildContext context,
    Future<void> Function()? openFileInfo,
    Future<void> Function()? openChat,
  }) {
    UChatPopover.open(
      context: context,
      contentDxOffset: -120,
      menu: [
        if (openChat != null)
          PopoverMenuItem(
            onPressed: (_) => openChat(),
            title: 'Open chat'.tr,
          ),
        if (openFileInfo != null)
          PopoverMenuItem(
            hasBottomDivider: true,
            onPressed: (_) => openFileInfo(),
            title: 'Details'.tr,
          ),
        PopoverMenuItem(
          onPressed: (_) async {
            Get.back();
          },
          title: 'Cancel'.tr,
          customFontStyle: PopoverMenuItem.fontStyle.copyWith(
            color: const Color(0xFFFF1552),
          ),
        ),
      ],
    );
  }
}
