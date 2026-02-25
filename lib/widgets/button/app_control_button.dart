import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class AppControlButton extends StatelessWidget {
  const AppControlButton({
    super.key,
    required this.svgAsset,
    required this.iconAlignment,
    required this.label,
    required this.mainAxisAlignment,
    this.onTap,
    this.actionColor,
    this.iconColor,
    this.showLabel = true,
    this.showIcon = true,
    this.isBold = false,
  });

  final SvgPicture svgAsset;
  final IconAlignment iconAlignment;
  final String label;
  final void Function()? onTap;
  final Color? actionColor;
  final Color? iconColor;
  final bool showLabel;
  final bool showIcon;
  final MainAxisAlignment mainAxisAlignment;
  final bool isBold;

  /// default label is 'Next'
  factory AppControlButton.custom({
    Key? key,
    required BuildContext context,
    String? label,
    VoidCallback? onTap,
    Color? actionColor,
    bool showLabel = true,
    bool showIcon = true,
    bool isBold = false,
    required SvgPicture svgAsset,
  }) {
    return AppControlButton(
      key: key,
      svgAsset: svgAsset,
      mainAxisAlignment: MainAxisAlignment.end,
      iconAlignment: IconAlignment.end,
      label: label ?? '',
      actionColor: actionColor ?? context.theme.appColors.textPrimary,
      onTap: onTap,
      showLabel: showLabel,
      showIcon: showIcon,
      isBold: isBold,
    );
  }

  /// default label is 'Next'
  factory AppControlButton.forward({
    Key? key,
    required BuildContext context,
    String? label,
    VoidCallback? onTap,
    Color? actionColor,
    bool showLabel = true,
    bool showIcon = false,
    bool isBold = false,
  }) {
    return AppControlButton(
      key: key,
      svgAsset: Assets.vectors.chevronForwardIos.svg(
        colorFilter: ColorFilter.mode(
          context.theme.appColors.iconPrimary,
          BlendMode.srcIn,
        ),
      ),
      mainAxisAlignment: MainAxisAlignment.end,
      iconAlignment: IconAlignment.end,
      label: label ?? 'Next'.tr,
      actionColor: actionColor ?? context.theme.appColors.textPrimary,
      onTap: onTap,
      showLabel: showLabel,
      showIcon: showIcon,
      isBold: isBold,
    );
  }

  /// defacto label is 'Back'.tr
  factory AppControlButton.back({
    Key? key,
    required BuildContext context,
    String? label,
    VoidCallback? onTap,
    Color? actionColor,
    Color? iconColor,
    bool showLabel = true,
    bool showIcon = true,
  }) {
    return AppControlButton(
      key: key,
      svgAsset: Assets.vectors.chevronBackIos.svg(
        colorFilter: ColorFilter.mode(
          iconColor ?? context.theme.appColors.iconPrimary,
          BlendMode.srcIn,
        ),
      ),
      iconAlignment: IconAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      label: label ?? 'Back'.tr,
      actionColor: actionColor ?? context.theme.appColors.textPrimary,
      onTap: onTap ??
          () {
            Get.back();
          },
      showLabel: showLabel,
      showIcon: showIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (showIcon && iconAlignment == IconAlignment.start) svgAsset,
          if (showLabel)
            Flexible(
              child: isBold
                  ? AppText.button1Bold(
                      label,
                      context: context,
                      color: actionColor ?? context.theme.appColors.textPrimary,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    )
                  : AppText.button1(
                      label,
                      context: context,
                      color: actionColor ?? context.theme.appColors.textPrimary,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
            ),
          if (showIcon && iconAlignment == IconAlignment.end) svgAsset,
        ],
      ),
    );
  }
}
