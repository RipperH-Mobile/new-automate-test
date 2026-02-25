import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/widgets/menu_list/menu_list_item.dart';

class MenuListBox extends StatelessWidget {
  /// The width of the menu list box.
  ///
  /// - If not provided, it will use the default width of `224.spMin`.
  /// - If the width is less than the minWidth, it will override the minWidth.
  final double? width;

  /// The border color of the menu list box.
  ///
  /// - If not provided, it will use the default border color from the theme.
  final Color? borderColor;

  /// The box shadow of the menu list box
  ///
  /// - If not provided, it will use the default box shadow
  /// - If provided, it will override the default box shadow
  ///
  /// Default box shadow:
  /// ```dart
  /// BoxShadow(
  ///   color: Colors.black.withValues(alpha: .1),
  ///   blurRadius: 8.sp,
  ///   offset: Offset(0, 2.sp),
  /// )
  /// ```
  final BoxShadow? boxShadow;

  /// The space between each menu list item
  ///
  /// This will be applied to the space between each menu list item
  ///
  /// - If not provided, it will use the default space of `1.spMin`
  /// - If provided, it will override the default space
  final double? menuSpace;

  /// The list of menu list items
  ///
  /// - The list of menu list items to be displayed in the menu list box
  /// - The list of menu list items must not be empty and must contain at least one menu list item
  final List<MenuListItem> menuItems;

  const MenuListBox({
    required this.menuItems,
    super.key,
    this.width,
    this.borderColor,
    this.boxShadow,
    this.menuSpace,
  }) : assert(menuItems.length > 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 224.spMin,
      decoration: BoxDecoration(
        color: borderColor ?? context.theme.appColors.border,
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        border: Border.all(color: borderColor ?? context.theme.appColors.border),
        boxShadow: [
          boxShadow ??
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 8.sp,
                offset: Offset(0, 2.sp),
              ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: menuSpace ?? 1.spMin,
          children: menuItems,
        ),
      ),
    );
  }
}
