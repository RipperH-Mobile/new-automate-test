import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_gift_history_type.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_setting_gift_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_setting_gift/widgets/sticker_gift_receive_history_list.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_setting_gift/widgets/sticker_gift_sent_history_list.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_offline_mode_indicator.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_pack_list_item_shimmer.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class StickerSettingGiftScreen extends GetView<StickerSettingGiftController> {
  const StickerSettingGiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.elevationSurfaceDark,
      appBar: AppBarDefault(
        title: 'Gift'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
        leadingWidth: AppSpace.space20,
        automaticallyImplyLeading: false,
        backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.theme.appColors.backgroundNeutralLightestPressed,
            borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
          ),
          margin: const EdgeInsets.only(
            left: AppSpace.space4,
            right: AppSpace.space4,
            bottom: AppSpace.space4,
          ),
          child: GetBuilder<StickerSettingGiftController>(
              id: StickerSettingGiftIds.mainContentBox,
              builder: (controller) {
                if (ConnectivityController.instance.isOffline) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StickerOfflineModeIndicator(),
                      SizedBox(
                        // kToolbarHeight is app bar height. * 2 is to make text more centered in the screen.
                        height: kToolbarHeight * 2,
                        width: double.infinity,
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        controller: controller.historyTypeTabController,
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
                        tabs: [
                          Tab(text: StickerGiftHistoryType.received.translatedValue),
                          Tab(text: StickerGiftHistoryType.sent.translatedValue),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: context.theme.appColors.border,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.historyTypeTabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          GetBuilder<StickerSettingGiftController>(
                            id: StickerSettingGiftIds.receivedHistoryList,
                            builder: (controller) {
                              if (controller.isInitializing) {
                                return const Column(
                                  children: [
                                    StickerPackListItemShimmer(hasBottomBorderRadius: false),
                                    StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                                    StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                                    StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                                    StickerPackListItemShimmer(hasTopBorderRadius: false),
                                  ],
                                );
                              } else if (controller.receivedHistoryList.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No stickers received'.tr,
                                    style: context.theme.appTexts.body2Bold.copyWith(
                                      color: context.theme.appColors.textDark,
                                    ),
                                  ),
                                );
                              }
                              return StickerGiftReceiveHistoryList(
                                receivedHistoryList: controller.receivedHistoryList,
                                scrollController: controller.receivedTabScrollController,
                                onPressed: (String id) {
                                  controller.handleStickerPackPressed(id);
                                },
                              );
                            },
                          ),
                          GetBuilder<StickerSettingGiftController>(
                            id: StickerSettingGiftIds.sentHistoryList,
                            builder: (controller) {
                              if (controller.isInitializing) {
                                return const Column(
                                  children: [
                                    StickerPackListItemShimmer(hasBottomBorderRadius: false),
                                    StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                                    StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                                    StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                                    StickerPackListItemShimmer(hasTopBorderRadius: false),
                                  ],
                                );
                              } else if (controller.sentHistoryList.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No stickers sent'.tr,
                                    style: context.theme.appTexts.body2Bold.copyWith(
                                      color: context.theme.appColors.textDark,
                                    ),
                                  ),
                                );
                              }
                              return StickerGiftSentHistoryList(
                                sentHistoryList: controller.sentHistoryList,
                                scrollController: controller.sentTabScrollController,
                                onPressed: (String id) {
                                  controller.handleStickerPackPressed(id);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
