import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class AboutCoinSection extends StatelessWidget {
  const AboutCoinSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.space3),
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLighter,
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.space2,
        children: [
          AppText.body3Bold(
            'About coins'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          AppText.body4(
            '- Coins purchased in UChat are non-refundable under any circumstances.'.tr,
            context: context,
            color: context.theme.appColors.textLight,
          ),
          AppText.body4(
            '- To transfer purchased coins when changing devices or phone numbers, you must link your UChat account to an email first.'
                .tr,
            context: context,
            color: context.theme.appColors.textLight,
          ),
          AppText.body4(
            '- Purchased coins will only be stored in the same operating system. When logging in on a different operating system, those coins will not be usable.'
                .tr,
            context: context,
            color: context.theme.appColors.textLight,
          ),
        ],
      ),
    );
  }
}
