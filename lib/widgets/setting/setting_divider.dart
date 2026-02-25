import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

class SettingDivider extends StatelessWidget {
  const SettingDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: context.theme.appColors.divider,
    );
  }
}
