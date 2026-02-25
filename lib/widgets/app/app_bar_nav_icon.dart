import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension.dart';

class AppBarNavIcon extends StatelessWidget {
  final ImageProvider? icon;
  final Widget? iconWidget;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? foregroundColor;

  const AppBarNavIcon({
    super.key,
    this.icon,
    this.iconWidget,
    this.onPressed,
    this.bgColor,
    this.padding,
    this.width,
    this.height,
    this.foregroundColor,
  }) : assert(icon != null || iconWidget != null, 'Either icon or iconWidget must be provided.');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppSpace.space8,
      height: height ?? AppSpace.space8,
      decoration: BoxDecoration(
        color: bgColor ?? UTheme.color.highlightColor,
        borderRadius: BorderRadius.circular(40.spMin),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
          ),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: iconWidget ??
            Image(
              width: AppSpace.space6,
              height: AppSpace.space6,
              image: ResizeImage(
                icon!,
                width: AppSpace.space18.cacheSize,
              ),
            ),
      ),
    );
  }
}
