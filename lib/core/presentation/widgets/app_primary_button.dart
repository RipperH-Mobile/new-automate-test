import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class AppPrimaryButton extends StatelessWidget {
  final Function? onPressed;
  final String buttonText;
  final Widget? icon;
  final Color? buttonColor;
  final Color? textColor;
  final EdgeInsets? padding;
  final MainAxisSize? mainAxisSize;

  const AppPrimaryButton._internal({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.icon,
    this.buttonColor,
    this.textColor,
    this.padding,
    this.mainAxisSize,
  });

  factory AppPrimaryButton.roundedL({
    Key? key,
    required Function? onPressed,
    required String buttonText,
    Widget? icon,
    Color? buttonColor,
    Color? textColor,
    EdgeInsets? padding,
    MainAxisSize? mainAxisSize,
  }) {
    return AppPrimaryButton._internal(
      key: key,
      onPressed: onPressed,
      buttonText: buttonText,
      icon: icon,
      buttonColor: buttonColor,
      textColor: textColor,
      padding: padding ?? const EdgeInsets.all(AppSpace.space4),
      mainAxisSize: mainAxisSize,
    );
  }

  factory AppPrimaryButton.roundedS({
    Key? key,
    required Function? onPressed,
    required String buttonText,
    Widget? icon,
    Color? buttonColor,
    Color? textColor,
    MainAxisSize? mainAxisSize,
  }) {
    return AppPrimaryButton._internal(
      key: key,
      onPressed: onPressed,
      buttonText: buttonText,
      icon: icon,
      buttonColor: buttonColor,
      textColor: textColor,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpace.space2,
        horizontal: AppSpace.space4,
      ),
      mainAxisSize: mainAxisSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        border: Border.all(color: context.theme.appColors.border),
        color: buttonColor ?? context.theme.appColors.buttonPrimary,
      ),
      child: TextButton(
        onPressed: onPressed != null
            ? () {
                onPressed!();
              }
            : null,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSpace.space4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: mainAxisSize ?? MainAxisSize.max,
            children: [
              if (icon != null) icon!,
              if (icon != null) const SizedBox(width: AppSpace.space2),
              AppText.button2Bold(
                buttonText,
                context: context,
                color: textColor ?? context.theme.appColors.textPrimaryInverse,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
