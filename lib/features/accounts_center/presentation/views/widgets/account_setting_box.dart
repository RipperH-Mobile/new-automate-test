import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets/app_text.dart';

class AccountSettingBox extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final Widget? subtitle;
  final bool enable;

  const AccountSettingBox({
    super.key,
    required this.onTap,
    required this.child,
    this.leading,
    this.trailing,
    this.subtitle,
    this.enable = true,
  });

  factory AccountSettingBox.arrow({
    required Function onTap,
    required Widget child,
    required BuildContext context,
    Widget? leading,
    Widget? subtitle,
    String? trailingText,
  }) {
    return AccountSettingBox(
      onTap: onTap,
      leading: leading,
      trailing: Row(
        children: [
          if (trailingText != null) ...[
            AppText.body3(
              trailingText,
              color: context.theme.appColors.textLighter,
              context: context,
            ),
            const SizedBox(width: AppSpace.space3),
          ],
          Assets.vectors.iconArrowBackIos.svg(),
        ],
      ),
      subtitle: subtitle,
      child: child,
    );
  }

  factory AccountSettingBox.toggle({
    required Function onTap,
    required Widget child,
    required bool value,
    required Function(bool) onChanged,
    required BuildContext context,
    Widget? subtitle,
    bool enable = true,
  }) {
    return AccountSettingBox(
      onTap: onTap,
      trailing: SizedBox(
        width: 48.spMin,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: CupertinoSwitch(
            value: value,
            activeTrackColor: UTheme.color.primary,
            thumbColor: const Color(0xFFF2F2F2),
            inactiveTrackColor: const Color(0xFFCCCCCC),
            onChanged: enable ? onChanged : null,
          ),
        ),
      ),
      // TODO (design system) Uncomment this when new design system is implemented.
      // trailing: CustomSwitch(
      //   value: value,
      //   onChanged: enable ? onChanged : null,
      // ),
      subtitle: subtitle,
      enable: enable,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enable
          ? () {
              onTap();
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          color: enable
              ? context.theme.appColors.backgroundNeutralLightestPressed
              : context.theme.appColors.backgroundNeutralLighter,
          // TODO (design system) Update this when new design system is implemented.
          borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        ),
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
        child: Row(
          crossAxisAlignment: subtitle != null ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      if (leading != null) ...[
                        leading!,
                        const SizedBox(width: AppSpace.space3),
                      ],
                      child,
                    ],
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(
                      height: AppSpace.space1,
                    ),
                    subtitle!
                  ],
                ],
              ),
            ),
            const SizedBox(
              width: AppSpace.space4,
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
