import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class StickerSettingScreen extends StatelessWidget {
  const StickerSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
      appBar: AppBarDefault(
        title: 'Sticker setting'.tr,
        leadingButton: AppControlButton.back(
          context: context,
        ),
        leadingWidth: AppSpace.space20,
        automaticallyImplyLeading: false,
        backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
      ),
      child: Container(
        margin: const EdgeInsets.only(left: AppSpace.space4, right: AppSpace.space4),
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundNeutralLightestPressed,
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildBox(
              context,
              title: 'My stickers'.tr,
              icon: Assets.vectors.iconStickerSetting.svg(),
              isTop: true,
              onTap: () {
                Get.toNamed(Routes.stickerSettingMySticker);
              },
            ),
            _buildBox(
              context,
              title: 'Favorite'.tr,
              icon: Assets.vectors.iconWishList.svg(),
              onTap: () {
                Get.toNamed(Routes.stickerFavorite);
              },
            ),
            _buildBox(
              context,
              title: 'Purchase history'.tr,
              icon: Assets.vectors.iconPurchaseHistory.svg(),
              onTap: () {
                Get.toNamed(Routes.stickerSettingPurchaseHistory);
              },
            ),
            _buildBox(
              context,
              title: 'Gift'.tr,
              icon: Assets.vectors.iconStickerGift.svg(),
              isBottom: true,
              showDivider: false,
              onTap: () {
                Get.toNamed(Routes.stickerSettingGift);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(
    BuildContext context, {
    required String title,
    required Widget icon,
    bool showDivider = true,
    required void Function() onTap,
    bool isTop = false,
    bool isBottom = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space4,
                right: AppSpace.space4,
                top: AppSpace.space3,
                bottom: AppSpace.space3,
              ),
              child: Row(
                children: [
                  icon,
                  const SizedBox(width: AppSpace.space4),
                  AppText.body1(
                    title,
                    context: context,
                  ),
                  const Spacer(),
                  Assets.vectors.iconArrowBackIos.svg(),
                ],
              ),
            ),
            if (showDivider)
              Padding(
                padding: const EdgeInsets.only(left: AppSpace.space14),
                child: Divider(
                  color: context.theme.appColors.border,
                  height: AppSpace.spacePx,
                  thickness: AppSpace.spacePx,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
