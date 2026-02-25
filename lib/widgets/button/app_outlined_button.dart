import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/widgets/button/app_button_base.dart';

class AppOutlinedButton extends AppButtonBase {
  const AppOutlinedButton({
    super.key,
    required super.label,
    super.onTap,
    super.icon,
    required super.appButtonSize,
    required super.backgroundColor,
    required super.overlayColor,
    required super.textColor,
    required super.iconColor,
    required super.iconAlignment,
    required super.shape,
    super.isExpanded = true,
    super.isLoading = false,
    super.isAutoSizeText = false,
  });

  factory AppOutlinedButton.defaultButton({
    Key? key,
    required BuildContext context,
    required String label,
    VoidCallback? onTap,
    Widget? icon,
    Color? backgroundColor,
    Color? borderColor,
    Color? overlayColor,
    AppButtonStyle style = AppButtonStyle.rounded,
    AppButtonSize size = AppButtonSize.large,
    IconAlignment iconAlignment = IconAlignment.start,
    bool isExpanded = true,
    bool isLoading = false,
    bool isAutoSizeText = false,
  }) {
    return AppOutlinedButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: backgroundColor ?? context.theme.appColors.buttonSecondary,
      overlayColor: overlayColor ?? context.theme.appColors.buttonSecondaryPressed,
      textColor: context.theme.appColors.textDarkest,
      iconColor: context.theme.appColors.icon,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
        side: BorderSide(
          color: borderColor ?? context.theme.appColors.borderDarker,
          width: 1,
        ),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
      isAutoSizeText: isAutoSizeText,
    );
  }

  factory AppOutlinedButton.primary({
    Key? key,
    required BuildContext context,
    required String label,
    VoidCallback? onTap,
    Widget? icon,
    Color? borderColor,
    AppButtonStyle style = AppButtonStyle.rounded,
    AppButtonSize size = AppButtonSize.large,
    IconAlignment iconAlignment = IconAlignment.start,
    bool isExpanded = true,
    bool isLoading = false,
  }) {
    return AppOutlinedButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonSecondary,
      overlayColor: context.theme.appColors.buttonSecondaryPressed,
      textColor: context.theme.appColors.textPrimary,
      iconColor: context.theme.appColors.iconPrimary,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
        side: BorderSide(
          color: borderColor ?? context.theme.appColors.border,
          width: 1,
        ),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
    );
  }

  factory AppOutlinedButton.error({
    Key? key,
    required BuildContext context,
    required String label,
    VoidCallback? onTap,
    Widget? icon,
    AppButtonStyle style = AppButtonStyle.rounded,
    AppButtonSize size = AppButtonSize.large,
    IconAlignment iconAlignment = IconAlignment.start,
    bool isExpanded = true,
    bool isLoading = false,
  }) {
    return AppOutlinedButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonSecondary,
      overlayColor: context.theme.appColors.buttonSecondaryPressed,
      textColor: context.theme.appColors.buttonError,
      iconColor: context.theme.appColors.iconError,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
        side: BorderSide(
          color: context.theme.appColors.border,
          width: 1,
        ),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
    );
  }

  factory AppOutlinedButton.success({
    Key? key,
    required BuildContext context,
    required String label,
    VoidCallback? onTap,
    Widget? icon,
    AppButtonStyle style = AppButtonStyle.rounded,
    AppButtonSize size = AppButtonSize.large,
    IconAlignment iconAlignment = IconAlignment.start,
    bool isExpanded = true,
    bool isLoading = false,
  }) {
    return AppOutlinedButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonSecondary,
      overlayColor: context.theme.appColors.buttonSecondaryPressed,
      textColor: context.theme.appColors.buttonSuccess,
      iconColor: context.theme.appColors.iconSuccess,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
        side: BorderSide(
          color: context.theme.appColors.border,
          width: 1,
        ),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
    );
  }

  factory AppOutlinedButton.warning({
    Key? key,
    required BuildContext context,
    required String label,
    VoidCallback? onTap,
    Widget? icon,
    AppButtonStyle style = AppButtonStyle.rounded,
    AppButtonSize size = AppButtonSize.large,
    IconAlignment iconAlignment = IconAlignment.start,
    bool isExpanded = true,
    bool isLoading = false,
  }) {
    return AppOutlinedButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonSecondary,
      overlayColor: context.theme.appColors.buttonSecondaryPressed,
      textColor: context.theme.appColors.buttonWarning,
      iconColor: context.theme.appColors.iconWarning,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
        side: BorderSide(
          color: context.theme.appColors.buttonWarning,
          width: 1,
        ),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
    );
  }
}
