import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/app_text.dart';

class ButtonForEditScreen extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double? height;

  const ButtonForEditScreen({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 180.spMin,
      height: height ?? 60.spMin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.spMin),
        border: Border.all(
          color: borderColor ?? context.theme.appColors.borderDisable,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(horizontal: 8),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.spMin), // Set border radius
            ),
          ),
          elevation: WidgetStateProperty.all(0),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: AppText.body3Bold(
          text,
          context: context,
          color: textColor,
        ),
      ),
    );
  }
}
