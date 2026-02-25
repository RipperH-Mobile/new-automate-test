import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_setting_purchase_history_controller.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_offline_mode_indicator.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_pack_list_item.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_pack_list_item_shimmer.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class StickerSettingPurchaseHistoryScreen extends GetView<StickerSettingPurchaseHistoryController> {
  const StickerSettingPurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.elevationSurfaceDark,
      appBar: AppBarDefault(
        title: 'Purchase history'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
        leadingWidth: AppSpace.space20,
        automaticallyImplyLeading: false,
        backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
      ),
      body: GetBuilder<StickerSettingPurchaseHistoryController>(
        id: StickerSettingPurchaseHistoryIds.stickerPurchaseHistoryListId,
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
          if (controller.initializing) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
              padding: const EdgeInsets.symmetric(vertical: AppSpace.space2),
              decoration: BoxDecoration(
                color: context.theme.appColors.backgroundNeutralLightestPressed,
                borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StickerPackListItemShimmer(hasBottomBorderRadius: false),
                  SizedBox(height: AppSpace.space05),
                  StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                  SizedBox(height: AppSpace.space05),
                  StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                  SizedBox(height: AppSpace.space05),
                  StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                  SizedBox(height: AppSpace.space05),
                  StickerPackListItemShimmer(hasTopBorderRadius: false),
                ],
              ),
            );
          }
          if (controller.purchaseHistoryList.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
                right: AppSpace.space4,
                bottom: AppSpace.space4,
              ),
              child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.purchaseHistoryList.length,
                itemBuilder: (context, index) {
                  final pack = controller.purchaseHistoryList[index];
                  return StickerPackListItem(
                    title: pack.name,
                    subtitle: 'Purchase date: @date'
                        .trParams({'date': pack.receivedAt?.format('dd/MM/yyyy') ?? 'Unknown Date'.tr}),
                    packId: pack.id,
                    fileId: pack.coverId,
                    onPressed: () => controller.onTapStickerItem(pack),
                    hasTopBorderRadius: index == 0,
                    hasBottomBorderRadius: index == controller.purchaseHistoryList.length - 1,
                    hasDivider: index != controller.purchaseHistoryList.length - 1,
                  );
                },
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText.body2Bold('No purchase history'.tr, context: context),
                // Empty box to push text up to the center of the screen because app bar takes some space.
                // This is to make the text vertically centered in the screen. not centered in the remaining space.
                const SizedBox(
                  // kToolbarHeight is app bar height. * 2 is to make text more centered in the screen.
                  height: kToolbarHeight * 2,
                  width: double.infinity,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
