import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class CallStatusWidget extends StatelessWidget {
  final String status;
  final bool active;

  const CallStatusWidget({super.key, required this.status, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space3,
        vertical: AppSpace.space1,
      ),
      // TODO: fix color
      decoration: BoxDecoration(
        color: active
            ? context.theme.appColors.backgroundNeutralLightest
            : const Color(0x527C7C7C).withValues(
                alpha: 0.32,
              ),
        borderRadius: BorderRadius.circular(
          AppRadius.roundedFull,
        ),
      ),
      child: AppText.body2Bold(
        status,
        context: context,
        color: active ? context.theme.appColors.textDarkest : context.theme.appColors.textPrimaryInverse,
        textAlign: TextAlign.center,
        lineHeight: 18 / 14,
      ),
    );
  }
}
