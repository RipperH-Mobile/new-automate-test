import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

class ContactTile extends StatelessWidget {
  final Function onTap;
  final String name;
  final String? subtitle;
  final String? avatarUrl;

  // Widget to be place before contact name such as official account icon.
  final Widget? leadingWidget;

  // Widget to be place after contact name such as group member count.
  final Widget? trailingWidget;
  final Color? backgroundColor;

  // Variable for checkbox
  final bool? isSelected;
  final Function(bool?)? onChanged;
  final bool showCheckBox;

  const ContactTile({
    super.key,
    required this.onTap,
    required this.name,
    this.subtitle,
    this.avatarUrl,
    this.leadingWidget,
    this.trailingWidget,
    this.backgroundColor,
    this.isSelected,
    this.onChanged,
    this.showCheckBox = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // Material is use here for tap splash animation from InkWell to work.
      color: backgroundColor ?? context.theme.appColors.backgroundNeutralLightest,
      child: InkWell(
        onTap: () {
          onTap();
        },
        splashColor: context.theme.appColors.backgroundNeutralLightestPressed,
        child: Row(
          children: [
            Avatar(
              url: avatarUrl,
              radius: AppRadius.rounded3xl,
            ),
            const SizedBox(width: AppSpace.space4),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: context.theme.appColors.border,
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leadingWidget != null) leadingWidget!,
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints(minHeight: AppSize.size8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Flexible is used here to make the name text widget stretch if it need more space and
                                // to make textOverflow to work.
                                Flexible(
                                  child: AppText.body3Bold(
                                    name,
                                    context: context,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (trailingWidget != null) trailingWidget!,
                              ],
                            ),
                            if (subtitle?.isNotEmpty == true)
                              AppText.body4(
                                subtitle!,
                                context: context,
                                color: context.theme.appColors.textLight,
                                maxLines: 1,
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (showCheckBox) const SizedBox(width: AppSpace.space3),
                    if (showCheckBox)
                      RoundCheckBox(
                        isChecked: isSelected,
                        onTap: onChanged,
                        size: AppSize.size8,
                        border: Border.all(width: 0, color: Colors.transparent),
                        checkedColor: Colors.transparent,
                        // Prevent default green color from RoundCheckBox to display.
                        checkedWidget: Assets.vectors.checkBoxSelected.svg(),
                        uncheckedWidget: Assets.vectors.checkBox.svg(),
                        animationDuration: const Duration(milliseconds: 200),
                      ),
                    if (showCheckBox) const SizedBox(width: AppSpace.space4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
