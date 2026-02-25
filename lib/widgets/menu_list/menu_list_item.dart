import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class MenuListItem extends StatelessWidget {
  /// The text to be displayed in the menu list item.
  ///
  /// - The text must not be empty.
  final String text;

  /// The text color of the menu list item.
  final Color? textColor;

  /// The suffix icon of the menu list item.
  final Widget? suffixIcon;

  /// The callback function when the menu list item is tapped.
  final VoidCallback? onTap;

  const MenuListItem({
    super.key,
    required this.text,
    this.textColor,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: context.theme.appColors.backgroundNeutralLightest,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space4,
          vertical: AppSpace.space3,
        ),
        constraints: BoxConstraints(
          minHeight: 48.spMin,
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText.body1(
                text,
                context: context,
                color: textColor,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            if (suffixIcon != null) suffixIcon!,
          ],
        ),
      ),
    );
  }
}
