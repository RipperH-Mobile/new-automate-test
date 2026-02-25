import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/coin/presentation/controllers/coin_store_controller.dart';
import 'package:uchat/features/coin/presentation/screens/coin_store/widgets/about_coin_section.dart';
import 'package:uchat/features/coin/presentation/screens/coin_store/widgets/coin_store_header.dart';
import 'package:uchat/features/coin/presentation/screens/coin_store/widgets/coin_store_item_list.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class CoinStoreScreen extends StatelessWidget {
  const CoinStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF0057FF),
            Color(0xFF22A2FF),
          ],
        ),
      ),
      child: ScaffoldBasic(
        backgroundColor: Colors.transparent,
        appBar: AppBarDefault(
          title: 'Coins Store'.tr,
          titleColor: context.theme.appColors.textPrimaryInverse,
          leadingButton: AppControlButton.back(
            context: context,
            iconColor: context.theme.appColors.iconPrimaryInverse,
            actionColor: context.theme.appColors.iconPrimaryInverse,
          ),
          actionButton: GetBuilder<CoinStoreController>(
            builder: (ctl) {
              return AppControlButton.custom(
                context: context,
                svgAsset: Assets.vectors.history.svg(),
                onTap: ctl.onGoToCoinHistory,
              );
            },
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: AppSpace.space4, right: AppSpace.space4, top: AppSpace.space2),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.space6),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.theme.appColors.backgroundNeutralLightestPressed,
                    borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                    border: Border.all(
                      color: context.theme.appColors.border,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: context.theme.appColors.textDarkest.withValues(alpha: .2),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpace.space4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: AppSpace.space3),
                          child: CoinStoreHeader(),
                        ),
                        GetBuilder<CoinStoreController>(
                          id: CoinStoreIds.coinAds,
                          builder: (ctl) {
                            if (ctl.isLoadingCoinAds || ctl.coinAdsText.isEmpty) {
                              return const SizedBox.shrink();
                            }

                            return Container(
                              height: 42.spMin,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: AppSpace.space4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: context.theme.appGradientColors.gradientBlue,
                                ),
                              ),
                              child: Center(
                                child: AppText.body3Bold(
                                  ctl.coinAdsText.isNotEmpty ? ctl.coinAdsText : 'Buy coins and receive a bonus!'.tr,
                                  context: context,
                                  color: context.theme.appColors.textPrimaryInverse,
                                ),
                              ),
                            );
                          },
                        ),

                        // Coin store items
                        const CoinStoreItemList(),
                        AppSpace.space4.verticalSpace,
                        // About coin section
                        const AboutCoinSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
