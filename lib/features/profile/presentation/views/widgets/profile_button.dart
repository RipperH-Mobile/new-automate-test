import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    this.icon,
    this.label,
    required this.onTap,
    this.iconOnlyDiameter = 28,
    this.verticalPadding = AppSpace.space1, // vertical padding for horizontal pill
    this.horizontalPadding = AppSpace.space4, // horizontal padding for pill width
    this.spacing = AppSpace.space015,
  }) : assert(icon != null || label != null, 'Provide either an icon, a label, or both.');

  final Widget? icon;
  final Widget? label;
  final VoidCallback onTap;
  final double iconOnlyDiameter;
  final double verticalPadding;
  final double horizontalPadding;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final bool iconOnly = label == null;

    return InkWell(
      borderRadius: BorderRadius.circular(
        iconOnly ? iconOnlyDiameter / 2 : 100,
      ),
      onTap: onTap,
      child: iconOnly
          ? Container(
              width: iconOnlyDiameter,
              height: iconOnlyDiameter,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.context!.theme.appColors.buttonBlackTransparent,
              ),
              alignment: Alignment.center,
              child: icon,
            )
          : Container(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding, // Small vertical = horizontal pill
                horizontal: horizontalPadding, // Larger horizontal = wider pill
              ),
              decoration: BoxDecoration(
                color: Get.context!.theme.appColors.buttonBlackTransparent,
                borderRadius: BorderRadius.circular(AppRadius.roundedFull),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) icon!,
                  if (icon != null) SizedBox(width: spacing),
                  label!,
                ],
              ),
            ),
    );
  }
}
