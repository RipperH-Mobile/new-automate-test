import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_favorite_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_favorite/widgets/favorite_sticker_pack_list_item.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_offline_mode_indicator.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_pack_list_item_shimmer.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class StickerFavoriteScreen extends GetView<StickerFavoriteController> {
  const StickerFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.elevationSurfaceDark,
      appBar: AppBarDefault(
        title: 'Favorite'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
        leadingWidth: AppSpace.space20,
        automaticallyImplyLeading: false,
        backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
      ),
      body: GetBuilder<StickerFavoriteController>(
        id: StickerFavoriteIds.stickerFavoriteListId,
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
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpace.space4),
              child: Column(
                children: [
                  StickerPackListItemShimmer(hasBottomBorderRadius: false),
                  StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                  StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                  StickerPackListItemShimmer(hasTopBorderRadius: false, hasBottomBorderRadius: false),
                  StickerPackListItemShimmer(hasTopBorderRadius: false),
                ],
              ),
            );
          }
          if (controller.favoriteList.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
              child: ListView.builder(
                itemCount: controller.favoriteList.length,
                itemBuilder: (context, index) {
                  return GetBuilder<StickerFavoriteController>(
                    id: StickerFavoriteIds.stickerFavoriteItemId.replaceAll(':id', controller.favoriteList[index].id),
                    builder: (controller) {
                      final pack = controller.favoriteList[index];

                      return FavoriteStickerPackListItem(
                        pack: pack,
                        onPressed: () => controller.handleStickerPackPressed(pack),
                        onHeartPressed: () => controller.handlePressFavorite(index),
                        hasTopBorderRadius: index == 0,
                        hasBottomBorderRadius: index == controller.favoriteList.length - 1,
                        hasDivider: index > 0,
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No stickers have been added'.tr,
                  style: context.theme.appTexts.body2Bold.copyWith(
                    color: context.theme.appColors.textDark,
                  ),
                ),
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
