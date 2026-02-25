import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';

class CoinItemBadge extends StatelessWidget {
  final String text;

  const CoinItemBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundError,
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space1, vertical: AppSpace.space05),
        child: Text(
          text,
          style: context.theme.appTexts.caption2Bold.copyWith(
            color: context.theme.appColors.textErrorInverse,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
