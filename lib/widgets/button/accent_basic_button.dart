import 'package:flutter/material.dart';
import 'package:uchat/themes/themes.dart';
import 'basic_button.dart';

class AccentBasicButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;
  final double? height;
  final String title;
  final bool isRounded;

  const AccentBasicButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    this.isRounded = true,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BasicButton(
      onPressed: onPressed,
      buttonColor: UTheme.color.accent,
      title: title,
      width: width,
      height: height,
      isRounded: isRounded,
      textStyle: UTheme.textTheme.buttonLabel,
      textColor: UTheme.color.onAccent,
    );
  }
}
