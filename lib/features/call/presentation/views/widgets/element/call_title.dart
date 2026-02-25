import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

class CallTitleWidget extends StatelessWidget {
  final String title;

  const CallTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.theme.appTexts.heading3.copyWith(
        color: context.theme.appColors.textPrimaryInverse,
        shadows: [
          // TODO: fix shadow
          Shadow(
            offset: const Offset(0, 0),
            blurRadius: 6,
            color: const Color(0xFF000000).withValues(
              alpha: 0.4,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
