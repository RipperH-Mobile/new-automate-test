// widgets/settings/settings_toggle_item.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class ProfileToggleMenu extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? titleColor;
  final bool? dense;

  const ProfileToggleMenu({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.titleColor,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: AppSpace.space4,
        right: AppSpace.space3,
      ),
      dense: dense ?? false,
      title: AppText.body1(
        title,
        color: titleColor ?? context.theme.appColors.textDarkest,
        context: context,
      ),
      trailing: SizedBox(
        width: AppSize.size12,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: context.theme.appColors.backgroundPrimary,
            thumbColor: context.theme.appColors.backgroundNeutralLightest,
            inactiveTrackColor: context.theme.appColors.iconDisable,
          ),
        ),
      ),
    );
  }
}
