import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class CoinHistoryOffline extends StatelessWidget {
  const CoinHistoryOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space20),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.theme.appColors.backgroundNeutralLight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSpace.space6),
                child: Assets.vectors.iconMoonOfflineV2.svg(),
              ),
            ),
            AppSpace.space4.verticalSpace,
            AppText.button2Bold('Currently offline'.tr, context: context),
            AppSpace.space1.verticalSpace,
            AppText.body4(
              'You can view history or purchase coins in online mode only'.tr,
              context: context,
              textAlign: TextAlign.center,
              color: context.theme.appColors.textDark,
            ),
          ],
        ),
      ),
    );
  }
}
