import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class SettingMeuBox extends StatelessWidget {
  const SettingMeuBox({
    super.key,
    required this.child,
    this.suffixIcon,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpace.space4,
      vertical: AppSpace.space3,
    ),
    this.onTap,
  });

  final Widget child;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  factory SettingMeuBox.textWithArrow({
    required BuildContext context,
    required String text,
    Widget? suffixIcon,
    VoidCallback? onTap,
    Key? key,
  }) {
    return SettingMeuBox(
      key: key,
      suffixIcon: Assets.vectors.chevronForwardIos.svg(
        height: 20,
        colorFilter: ColorFilter.mode(
          context.theme.appColors.iconLighter,
          BlendMode.srcIn,
        ),
      ),
      onTap: onTap,
      child: AppText.body1(
        text,
        context: context,
      ),
    );
  }

  factory SettingMeuBox.withArrow({
    required BuildContext context,
    required Widget child,
    Widget? suffixIcon,
    VoidCallback? onTap,
    Key? key,
  }) {
    return SettingMeuBox(
      key: key,
      suffixIcon: Assets.vectors.chevronForwardIos.svg(
        height: 20,
        colorFilter: ColorFilter.mode(
          context.theme.appColors.iconLighter,
          BlendMode.srcIn,
        ),
      ),
      onTap: onTap,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundNeutralLightestPressed,
          borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        ),
        child: Row(
          children: [
            Expanded(
              child: child,
            ),
            if (suffixIcon != null) ...[
              const SizedBox(
                width: AppSpace.space4,
              ),
              suffixIcon!
            ],
          ],
        ),
      ),
    );
  }
}
