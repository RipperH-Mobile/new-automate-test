import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class MuteMicBadge extends StatelessWidget {
  final String displayName;

  const MuteMicBadge({
    super.key,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpace.space4,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space3,
        vertical: AppSpace.space2,
      ),
      // TODO: fix color
      decoration: BoxDecoration(
        color: const Color(0x527C7C7C).withValues(
          alpha: 0.32,
        ),
        borderRadius: BorderRadius.circular(
          AppRadius.roundedFull,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.vectors.callMuteMicIcon.svg(
            height: AppSize.size6,
          ),
          const SizedBox(
            width: AppSpace.space1,
          ),
          Flexible(
            child: AppText.body3(
              '$displayName ',
              context: context,
              color: context.theme.appColors.textPrimaryInverse,
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          AppText.body3(
            'is muted'.tr,
            context: context,
            color: context.theme.appColors.textPrimaryInverse,
            textAlign: TextAlign.center,
            textOverflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
      ),
    );
  }
}
