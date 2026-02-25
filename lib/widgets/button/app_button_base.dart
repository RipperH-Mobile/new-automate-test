import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/widgets/app_text.dart';

abstract class AppButtonBase extends StatelessWidget {
  const AppButtonBase({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    required this.appButtonSize,
    required this.backgroundColor,
    required this.overlayColor,
    required this.textColor,
    required this.iconColor,
    required this.iconAlignment,
    required this.shape,
    this.isExpanded = true,
    this.isLoading = false,
    this.isAutoSizeText = false,
  });

  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final AppButtonSize appButtonSize;
  final Color backgroundColor;
  final Color overlayColor;
  final Color textColor;
  final Color iconColor;
  final IconAlignment iconAlignment;
  final RoundedRectangleBorder shape;
  final bool isExpanded;
  final bool isLoading;
  final bool isAutoSizeText;

  static BorderRadiusGeometry getBorderRadius(AppButtonStyle style) {
    switch (style) {
      case AppButtonStyle.sharp:
        return BorderRadius.zero;
      case AppButtonStyle.rounded:
        return BorderRadius.circular(
          AppRadius.roundedXl,
        );
      case AppButtonStyle.fullRounded:
        return BorderRadius.circular(
          AppRadius.roundedFull,
        );
    }
  }

  EdgeInsetsGeometry get padding {
    switch (appButtonSize) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(
          vertical: AppSpace.space1 + AppSpace.space05,
          horizontal: AppSpace.space4,
        );
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(
          vertical: AppSpace.space2 + AppSpace.space05,
          horizontal: AppSpace.space4,
        );
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(
          vertical: AppSpace.space3 + AppSpace.space05,
          horizontal: AppSpace.space4,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: isExpanded
            ? WidgetStateProperty.all(
                const Size(double.infinity, 0),
              )
            : null,
        shape: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return shape.copyWith(
                side: shape.side.copyWith(
                  color: context.theme.appColors.border,
                ),
              );
            }
            return shape;
          },
        ),
        padding: WidgetStateProperty.all(
          padding,
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (states) {
            return overlayColor;
          },
        ),
        splashFactory: InkSparkle.splashFactory,
        backgroundColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return context.theme.appColors.buttonDisable;
            }
            return backgroundColor;
          },
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        iconColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return context.theme.appColors.iconDisable;
            }
            return iconColor;
          },
        ),
        iconSize: WidgetStateProperty.all(
          AppSize.size6,
        ),
      ),
      icon: icon,
      iconAlignment: iconAlignment,
      label: AppText.button2Bold(
        label,
        context: context,
        color: onTap != null ? textColor : context.theme.appColors.textDisable,
        isAutoSizeText: isAutoSizeText,
      ),
    );
  }
}
