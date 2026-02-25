import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/effect/blur_box.dart';
import 'package:uchat/widgets/menu_list/menu_list_box.dart';
import 'package:uchat/widgets/menu_list/menu_list_item.dart';

class HoldWidgetWithMenu {
  /// The transition duration of the dialog in milliseconds.
  ///
  /// - Default value is `200`.
  static const transitionDurationDialogInMilliseconds = 200;

  /// Show the HoldWidgetWithMenu dialog.
  ///
  /// - [widget] is the widget to display.
  /// - [menuItems] is the list of menu list items.
  /// - [heroTag] is the optional hero tag for the widget.
  /// - [width] is the optional width of the menu list box. default is `224.spMin`.
  static Future<void> show(
    Widget widget,
    List<MenuListItem> menuItems, {
    required String barrierLabel,
    double? width,
  }) async {
    await showGeneralDialog(
      context: Get.context!,
      barrierDismissible: true,
      barrierLabel: barrierLabel,
      barrierColor: Get.theme.appColors.blanket,
      transitionDuration: const Duration(milliseconds: transitionDurationDialogInMilliseconds),
      transitionBuilder: _transitionBuilder,
      pageBuilder: (context, animation, secondaryAnimation) => _pageBuilder(
        context,
        widget,
        menuItems,
        width: width,
      ),
    );
  }

  static Widget _transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curvedValue = Curves.easeInOut.transform(animation.value);
    return Transform.scale(
      scale: 1 - (1 - curvedValue) * 0.05,
      child: Opacity(
        opacity: curvedValue,
        child: child,
      ),
    );
  }

  /// The page builder of the dialog.
  ///
  /// - [context] is the build context.
  /// - [widget] is the widget to display.
  /// - [menuItems] is the list of menu list items.
  /// - [heroTag] is the optional hero tag for the widget.
  ///
  /// Return the widget.
  static Widget _pageBuilder(
    BuildContext context,
    Widget widget,
    List<MenuListItem> menuItems, {
    double? width,
  }) {
    Widget displayWidget = widget;

    return GestureDetector(
      onTap: () => Get.back(),
      child: SafeArea(
        child: BlurBox(
          blurWeight: 30,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.space4,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  displayWidget,
                  AppSpace.space4.verticalSpace,
                  Align(
                    alignment: Alignment.centerRight,
                    child: ZoomIn(
                      child: MenuListBox(
                        width: width,
                        menuItems: menuItems,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
