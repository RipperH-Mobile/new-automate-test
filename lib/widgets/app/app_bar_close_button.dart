import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/widgets.dart';

class AppBarCloseButton extends StatelessWidget {
  final void Function()? onPressed;
  final bool? roundedBg;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? roundedPadding;

  const AppBarCloseButton({
    super.key,
    this.onPressed,
    this.roundedBg,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.roundedPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AppBarIconLeadingButton(
      icon: Container(
        padding: roundedBg == true ? roundedPadding ?? EdgeInsets.all(3.spMin) : EdgeInsets.zero,
        decoration: roundedBg == true
            ? BoxDecoration(
                color: backgroundColor ?? Colors.black26,
                shape: BoxShape.circle,
              )
            : null,
        child: Icon(
          Icons.close,
          size: iconSize ?? 24.spMin,
          color: roundedBg == true ? iconColor ?? Colors.white : iconColor,
        ),
      ),
      onPressed: () {
        onPressed?.call();
      },
    );
  }
}
