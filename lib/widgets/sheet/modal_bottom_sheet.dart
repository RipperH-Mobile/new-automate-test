import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/dimensions.dart';

Future<void> showUChatModalBottomSheet({
  required List<Widget> menus,
  Widget? title,
  enableLineHeader = true,
  isScrollControl = false,
  bool isDismissible = true,
  bool enableDrag = true,

  /// If true will set bottom sheet size to [height]
  /// If height is null default height is 30% of screen height.
  bool lockBottomSheetSize = false,

  /// Height of bottom sheet, Will be used if [lockBottomSheetSize] is true.
  double? height,

  /// Enable safe area space.
  bool enableLeftSafeArea = true,
  bool enableTopSafeArea = true,
  bool enableRightSafeArea = true,
  bool enableBottomSafeArea = true,
}) async {
  await Get.bottomSheet(
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: UTheme.color.bottomSheetBackground,
    SafeArea(
      left: enableLeftSafeArea,
      top: enableTopSafeArea,
      right: enableRightSafeArea,
      bottom: enableBottomSafeArea,
      child: Wrap(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: !enableLineHeader
                  ? const SizedBox.shrink()
                  : Container(
                      width: 65.wr,
                      height: 6.hr,
                      decoration: BoxDecoration(
                        color: UTheme.color.bottomSheetBar,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
            ),
          ),
          if (title != null) title,
          if (lockBottomSheetSize)
            SizedBox(
              height: height ?? Get.height * 0.3,
              child: Scrollbar(
                trackVisibility: true,
                child: ListView(
                  shrinkWrap: true,
                  children: menus,
                ),
              ),
            )
          else
            ...menus,
        ],
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    isScrollControlled: isScrollControl,
  );
}
