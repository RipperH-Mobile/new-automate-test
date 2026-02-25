import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/enums/sticker_search_tab.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_search_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_search/widgets/sticker_search_app_bar.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_search/widgets/sticker_search_result_list_view.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/widgets/sticker_pack_preview.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class StickerSearchScreen extends GetView<StickerSearchController> {
  const StickerSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: const StickerSearchAppBar(),
      child: Column(
        children: [
          // Tab Bar
          GetBuilder<StickerSearchController>(
            id: StickerSearchIds.tabBar,
            builder: (ctl) {
              if (ctl.searchTextController.text.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      controller: ctl.tabController,
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
                      tabs: StickerSearchTab.values.map((category) => Tab(text: category.value.tr)).toList(),
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                    color: context.theme.appColors.borderMenu,
                  ),
                ],
              );
            },
          ),

          // Search Results
          Expanded(
            child: GetBuilder<StickerSearchController>(
              id: StickerSearchIds.recentlySearchedStickers,
              builder: (ctl) {
                if (ctl.searchTextController.text.isNotEmpty) {
                  return TabBarView(
                    controller: controller.tabController,
                    children: StickerSearchTab.values.map(
                      (category) {
                        return StickerSearchResultListView(tab: category);
                      },
                    ).toList(),
                  );
                }

                if (ctl.recentlySearchedStickers.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText.body2Bold(
                            'No recent searches'.tr,
                            context: context,
                            textAlign: TextAlign.center,
                            color: context.theme.appColors.textDark,
                          ),
                          AppSpace.space05.verticalSpace,
                          AppText.body4(
                            'You don’t have any recent searches at the moment'.tr,
                            context: context,
                            textAlign: TextAlign.center,
                            color: context.theme.appColors.textLight,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSpace.space2, horizontal: AppSpace.space4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.body3Bold(
                            'Recent searches'.tr,
                            context: context,
                            color: context.theme.appColors.textDarkest,
                          ),
                          GestureDetector(
                            onTap: () {
                              UChatNewDialog.showConfirmClearRecentlyStickerSearch(
                                context: context,
                                onConfirm: () => ctl.clearRecentlySearchedStickers(),
                              );
                            },
                            child: AppText.body3Bold(
                              'Clear all'.tr,
                              context: context,
                              color: context.theme.appColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpace.space2.verticalSpace,
                    ...ctl.recentlySearchedStickers.map(
                      (sticker) {
                        return StickerPackPreview(
                          pack: sticker,
                          isVertical: false,
                          onTap: () {
                            ctl.onGoToStickerDetail(stickerPack: sticker);
                          },
                          onDelete: () {
                            ctl.deleteRecentlySearchedSticker(sticker);
                          },
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
