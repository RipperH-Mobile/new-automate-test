import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/app_text.dart';

class AppBarTitle extends StatelessWidget {
  final String title;
  final int fontSize;

  const AppBarTitle({
    super.key,
    required this.title,
    this.fontSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return AppText.heading2(
      title,
      context: context,
      color: context.theme.appColors.textDarkest,
    );
  }
}
