import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class DateMessageHeader extends StatelessWidget {
  final String dateHeader;

  const DateMessageHeader({super.key, required this.dateHeader});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Outer background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: AppSpace.space3),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space2,
              vertical: AppSpace.space05,
            ),
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundSystemMessage,
              borderRadius: BorderRadius.circular(AppRadius.roundedFull),
            ),
            child: AppText.caption2Bold(
              dateHeader,
              context: context,
              color: context.theme.appColors.textPrimaryInverse,
              lineHeight: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
