import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class CallInternetBadge extends StatelessWidget {
  const CallInternetBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space3,
        vertical: AppSpace.space2,
      ),
      // TODO: fix color
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLighterPressed,
        borderRadius: BorderRadius.circular(
          AppRadius.roundedFull,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.vectors.callInternetUnstable.svg(
            height: AppSize.size6,
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          AppText.body3(
            'Unstable network'.tr,
            context: context,
            color: context.theme.appColors.textError,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
