import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';

class BasicButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final Color buttonColor;
  final Color? buttonOverlayColor;
  final String title;
  final TextStyle textStyle;
  final Color? textColor;
  final Color? borderColor;
  final bool isRounded;
  final Widget? icon;
  final BorderRadiusGeometry? borderRadius;

  const BasicButton({
    super.key,
    required this.buttonColor,
    required this.title,
    required this.textStyle,
    this.onPressed,
    this.width,
    this.height,
    this.buttonOverlayColor,
    this.textColor,
    this.borderColor,
    this.isRounded = true,
    this.icon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (icon != null) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          SizedBox(width: 8.spMin),
          Text(title, style: textStyle.copyWith(color: textColor)),
        ],
      );
    } else {
      child = Text(title, style: textStyle.copyWith(color: textColor));
    }

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: buttonOverlayColor ?? UTheme.color.buttonOverlay,
        backgroundColor: onPressed == null ? buttonColor.withAlpha(128) : buttonColor,
        padding: EdgeInsets.zero,
        minimumSize: Size(btnWidth, btnHeight),
        shape: RoundedRectangleBorder(
          borderRadius:borderRadius ?? BorderRadius.circular(isRounded ? 15.spMin : 5.spMin),
        ),
        side: borderColor != null
            ? BorderSide(
                color: borderColor!,
                width: 1.spMin,
              )
            : null,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.spMin, horizontal: 5.spMin),
        width: btnWidth,
        height: btnHeight,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  double get btnWidth {
    double screenWidth = Get.width;

    return (width ?? screenWidth * 0.6).spMin;
  }

  double get btnHeight {
    return height ?? 50.spMin;
  }
}
