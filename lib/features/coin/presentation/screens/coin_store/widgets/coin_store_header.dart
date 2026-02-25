import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_tooltip.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/coin/presentation/controllers/coin_store_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class CoinStoreHeader extends StatelessWidget {
  const CoinStoreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: context.theme.appColors.textDarkest.withValues(alpha: .2),
                blurRadius: 12,
                spreadRadius: -5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Assets.vectors.iconUchatCoin.svg(
            width: 56.w,
            height: 56.h,
          ),
        ),
        AppSpace.space3.verticalSpace,
        AppText.body2Bold(
          'Coins balance'.tr,
          context: context,
          color: context.theme.appColors.textDark,
        ),
        AppSpace.space1.verticalSpace,
        GetBuilder<CoinStoreController>(
          id: CoinStoreIds.coinBalance,
          builder: (ctl) {
            if (ctl.isLoadingMyCoin) {
              return ShimmerLoading(
                enable: true,
                child: Container(
                  margin: const EdgeInsets.only(top: AppSpace.space1),
                  width: 120.w,
                  height: 38.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.roundedLg),
                  ),
                ),
              );
            }

            Color balanceColor = context.theme.appColors.textDarkest;
            if (ctl.coinBalance < 0) {
              balanceColor = context.theme.appColors.textError;
            }
            final hasSandboxCoin = ctl.sandboxCoinBalance > 0;

            return Row(
              spacing: AppSpace.space2,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedFlipCounter(
                  value: ctl.coinBalance,
                  thousandSeparator: ',',
                  duration: const Duration(milliseconds: 300),
                  textStyle: context.theme.appTexts.heading1.copyWith(color: balanceColor),
                ),
                if (hasSandboxCoin)
                  AppText.heading1(
                    '(+${NumberFormat.decimalPattern().format(ctl.sandboxCoinBalance)})',
                    context: context,
                    color: balanceColor,
                  ),
              ],
            ).withTooltip(
              'The additional coin is a Sandbox coin.\nIt is used only in the test environment \nand cannot be used to purchase any products.'.tr,
              enabled: hasSandboxCoin,
            );
          },
        ),
      ],
    );
  }
}
