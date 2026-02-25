import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';
import 'basic_button.dart';

class PrimaryBasicButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final String title;
  final bool isRounded;
  final Color? buttonColor;
  final TextStyle? textStyle;

  const PrimaryBasicButton({
    super.key,
    this.onPressed,
    this.width = 200,
    this.height,
    this.isRounded = true,
    required this.title,
    this.buttonColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      onPressed: onPressed,
      buttonColor: buttonColor ?? UTheme.color.primary,
      title: title,
      width: width,
      height: height,
      isRounded: isRounded,
      textStyle: textStyle ?? UTheme.textTheme.buttonLabel,
      textColor: textStyle?.color ?? UTheme.color.onPrimary,
    );
  }
}
