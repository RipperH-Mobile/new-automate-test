import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/coin/domain/enums/coin_history_tab.dart';
import 'package:uchat/features/coin/presentation/controllers/coin_history_controller.dart';
import 'package:uchat/features/coin/presentation/screens/coin_history/widgets/coin_history_balance.dart';
import 'package:uchat/features/coin/presentation/screens/coin_history/widgets/coin_history_list.dart';
import 'package:uchat/features/coin/presentation/screens/coin_history/widgets/coin_history_offline.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class CoinHistoryScreen extends StatelessWidget {
  const CoinHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinHistoryController>(
      id: CoinHistoryIds.coinHistoryOffline,
      builder: (ctl) {
        final appBar = AppBarDefault(
          title: 'History'.tr,
          leadingButton: AppControlButton.back(context: context),
        );

        if (ctl.isOffline) {
          return ScaffoldBasic(
            backgroundColor: context.theme.appColors.backgroundNeutralLightestPressed,
            appBar: appBar,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CoinHistoryOffline(),
                    AppSpace.space8.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        }

        return ScaffoldBasic(
          backgroundColor: context.theme.appColors.surfaceDark,
          appBar: appBar,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
              child: Column(
                children: [
                  const CoinHistoryBalance(),
                  AppSpace.space4.verticalSpace,
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.theme.appColors.backgroundNeutralLightestPressed,
                        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                      ),
                      child: Column(
                        children: [
                          GetBuilder<CoinHistoryController>(
                            id: CoinHistoryIds.coinHistoryTab,
                            builder: (controller) {
                              return Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Divider(
                                      height: 0.5,
                                      thickness: 1,
                                      color: context.theme.appColors.borderMenu,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: TabBar(
                                      controller: controller.coinHistoryTabController,
                                      isScrollable: true,
                                      labelColor: context.theme.appColors.textDarkest,
                                      indicatorColor: context.theme.appColors.textDarkest,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      labelPadding: const EdgeInsets.only(right: AppSpace.space4),
                                      labelStyle: context.theme.appTexts.button2Bold,
                                      unselectedLabelColor: context.theme.appColors.textLighter,
                                      indicatorWeight: 1.5,
                                      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                                      tabAlignment: TabAlignment.start,
                                      tabs:
                                          CoinHistoryTab.values.map((category) => Tab(text: category.display)).toList(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(AppRadius.rounded2xl),
                              ),
                              child: TabBarView(
                                controller: ctl.coinHistoryTabController,
                                children: List.generate(
                                  CoinHistoryTab.values.length,
                                  (index) {
                                    final tab = CoinHistoryTab.values[index];
                                    return CoinHistoryList(tab: tab);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
