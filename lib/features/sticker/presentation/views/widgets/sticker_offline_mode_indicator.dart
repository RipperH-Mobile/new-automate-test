import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerOfflineModeIndicator extends StatelessWidget {
  const StickerOfflineModeIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Assets.vectors.iconMoonOfflineV2.svg(),
        const SizedBox(height: AppSpace.space10),
        AppText.button2Bold(
          'Currently offline'.tr,
          context: context,
          color: context.theme.appColors.textDarkest,
        ),
        const SizedBox(height: AppSpace.space1),
        AppText.body4(
          'You can view history in online mode only'.tr,
          context: context,
          color: context.theme.appColors.textDark,
        ),
      ],
    );
  }
}
