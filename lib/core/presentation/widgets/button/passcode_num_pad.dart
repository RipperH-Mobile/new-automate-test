import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'rectangle_button.dart';

class PasscodeNumPad extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final Widget? widget;
  final Color? buttonColor;
  final TextStyle? textStyle;
  final bool isEnableScaleAnimation;
  final bool showHorizontalBorder;

  const PasscodeNumPad({
    super.key,
    this.label,
    this.onPressed,
    this.widget,
    this.buttonColor,
    this.textStyle,
    this.isEnableScaleAnimation = false,
    this.showHorizontalBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return RectangleButton(
        title: label,
        buttonColor: buttonColor ?? context.theme.appColors.backgroundNeutralLightest,
        textStyle: textStyle ??
            context.theme.appTexts.heading4.copyWith(
              color: context.theme.appColors.textDarkest,
            ),
        onPressed: onPressed,
        isEnableScaleAnimation: isEnableScaleAnimation,
        customBorder: showHorizontalBorder
            ? Border(
                top: BorderSide(
                  color: context.theme.appColors.border,
                  width: 1,
                ),
                left: BorderSide(
                  color: context.theme.appColors.border,
                  width: 1,
                ),
                right: BorderSide(
                  color: context.theme.appColors.border,
                  width: 1,
                ),
              )
            : Border(
                top: BorderSide(
                  color: context.theme.appColors.border,
                  width: 1,
                ),
              ),
        child: widget,
      );
    });
  }
}
