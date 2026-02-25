import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/entities/enum/app_button_style.dart';
import 'package:uchat/widgets/button/app_button_base.dart';

class AppFilledButton extends AppButtonBase {
  const AppFilledButton({
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

  factory AppFilledButton.defaultButton({
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
    bool isAutoSizeText = false,
  }) {
    return AppFilledButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonDefault,
      overlayColor: context.theme.appColors.buttonDefaultPressed,
      textColor: context.theme.appColors.textDarkest,
      iconColor: context.theme.appColors.icon,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
      isAutoSizeText: isAutoSizeText,
    );
  }

  factory AppFilledButton.primary({
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
    bool isAutoSizeText = false,
  }) {
    return AppFilledButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonPrimary,
      overlayColor: context.theme.appColors.buttonPrimaryPressed,
      textColor: context.theme.appColors.textPrimaryInverse,
      iconColor: context.theme.appColors.iconPrimaryInverse,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
      isAutoSizeText: isAutoSizeText,
    );
  }

  factory AppFilledButton.error({
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
    bool isAutoSizeText = false,
  }) {
    return AppFilledButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonError,
      overlayColor: context.theme.appColors.buttonErrorPressed,
      textColor: context.theme.appColors.textPrimaryInverse,
      iconColor: context.theme.appColors.iconErrorInverse,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
      isAutoSizeText: isAutoSizeText,
    );
  }

  factory AppFilledButton.success({
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
    bool isAutoSizeText = false,
  }) {
    return AppFilledButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonSuccess,
      overlayColor: context.theme.appColors.buttonSuccessPressed,
      textColor: context.theme.appColors.textPrimaryInverse,
      iconColor: context.theme.appColors.iconSuccessInverse,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
      isAutoSizeText: isAutoSizeText,
    );
  }

  factory AppFilledButton.warning({
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
    bool isAutoSizeText = false,
  }) {
    return AppFilledButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonWarning,
      overlayColor: context.theme.appColors.buttonWarningPressed,
      textColor: context.theme.appColors.textPrimaryInverse,
      iconColor: context.theme.appColors.iconWarningInverse,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
      isAutoSizeText: isAutoSizeText,
    );
  }

  factory AppFilledButton.black({
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
    bool isAutoSizeText = false,
  }) {
    return AppFilledButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: context.theme.appColors.buttonBlack,
      overlayColor: context.theme.appColors.buttonBlackPressed,
      textColor: context.theme.appColors.textPrimaryInverse,
      iconColor: context.theme.appColors.iconWarningInverse,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
      isAutoSizeText: isAutoSizeText,
    );
  }

  factory AppFilledButton.dark({
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
    Color? backgroundColor,
    bool isAutoSizeText = false,
  }) {
    return AppFilledButton(
      key: key,
      label: label,
      onTap: onTap,
      icon: icon,
      appButtonSize: size,
      backgroundColor: backgroundColor ?? context.theme.appColors.buttonDark,
      overlayColor: context.theme.appColors.buttonDarkPressed,
      textColor: context.theme.appColors.textPrimaryInverse,
      iconColor: context.theme.appColors.iconWarningInverse,
      iconAlignment: iconAlignment,
      shape: RoundedRectangleBorder(
        borderRadius: AppButtonBase.getBorderRadius(style),
      ),
      isExpanded: isExpanded,
      isLoading: isLoading,
      isAutoSizeText: isAutoSizeText,
    );
  }
}
