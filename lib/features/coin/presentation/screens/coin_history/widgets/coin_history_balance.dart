import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/coin/presentation/controllers/coin_history_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class CoinHistoryBalance extends StatelessWidget {
  const CoinHistoryBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
        child: Row(
          children: [
            AppText.body1(
              'Coin balance'.tr,
              context: context,
              color: context.theme.appColors.textDarkest,
            ),
            const Spacer(),
            Assets.vectors.iconUchatCoin.svg(width: 24.w, height: 24.w),
            AppSpace.space1.horizontalSpace,
            GetBuilder<CoinHistoryController>(
              id: CoinHistoryIds.coinHistoryBalance,
              builder: (ctl) {
                if (ctl.isLoadingCoinBalance) {
                  return ShimmerLoading(
                    enable: true,
                    child: Container(
                      width: 80.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        color: context.theme.appColors.backgroundNeutralLightest,
                        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                      ),
                    ),
                  );
                }

                Color balanceColor = context.theme.appColors.textDarkest;
                if (ctl.coinBalance < 0) {
                  balanceColor = context.theme.appColors.textError;
                }

                return AppText.body1Bold(
                  ctl.coinBalance.toNumberFormat(),
                  context: context,
                  color: balanceColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
