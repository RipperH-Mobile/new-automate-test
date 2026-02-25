import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/gen/assets.gen.dart';

class FavoriteStickerPackListItem extends StatelessWidget {
  final StoreStickerPackEntity pack;
  final VoidCallback onPressed;
  final VoidCallback onHeartPressed;
  final bool hasTopBorderRadius;
  final bool hasBottomBorderRadius;
  final bool hasDivider;

  const FavoriteStickerPackListItem({
    super.key,
    required this.pack,
    required this.onPressed,
    required this.onHeartPressed,
    this.hasTopBorderRadius = true,
    this.hasBottomBorderRadius = true,
    this.hasDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: context.theme.appColors.backgroundNeutralLightestPressed,
          borderRadius: BorderRadius.only(
            topLeft: hasTopBorderRadius ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
            topRight: hasTopBorderRadius ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
            bottomLeft: hasBottomBorderRadius ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
            bottomRight: hasBottomBorderRadius ? const Radius.circular(AppRadius.rounded2xl) : Radius.zero,
          ),
        ),
        padding: const EdgeInsets.only(left: AppSpace.space4),
        child: Row(
          children: [
            StickerItemPreview(
              packId: pack.id,
              fileId: pack.coverId,
              width: AppSize.size20,
              height: AppSize.size20,
            ),
            const SizedBox(
              width: AppSpace.space4,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasDivider)
                    Container(
                      color: context.theme.appColors.border,
                      height: AppSize.sizePx,
                      width: double.infinity,
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: AppSpace.space015,
                            ),
                            Text(
                              pack.name,
                              style: context.theme.appTexts.body1.copyWith(
                                color: context.theme.appColors.textDarkest,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              pack.publisher,
                              style: context.theme.appTexts.body3.copyWith(
                                color: context.theme.appColors.textLight,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              // When the pack isn't free, The coin icon take a little more space so when this pack isn't free
                              // this space is decreased a little to make size the same between free and not free.
                              height: pack.price == 0 ? AppSpace.space2 : AppSpace.space1,
                            ),
                            pack.price == 0
                                ? Text(
                                    'Free'.tr,
                                    style: context.theme.appTexts.body1Bold.copyWith(
                                      color: context.theme.appColors.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Row(
                                    children: [
                                      Assets.vectors.iconUchatCoin.svg(),
                                      const SizedBox(
                                        width: AppSpace.space1,
                                      ),
                                      Text(
                                        pack.price.toInt().toString(),
                                        style: context.theme.appTexts.body1Bold.copyWith(
                                          color: context.theme.appColors.textDarkest,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: AppSpace.space4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: AppSpace.space2,
                      ),
                      LikeButton(
                        size: AppSize.size6,
                        onTap: (bool value) async {
                          onHeartPressed();
                          // Not sure what does this lib used this return value for. Return null for now.
                          return null;
                        },
                        isLiked: pack.isFavorite,
                        circleColor: const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: const BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          return isLiked ? Assets.vectors.heartFilled.svg() : Assets.vectors.heart.svg();
                        },
                      ),
                      const SizedBox(
                        width: AppSpace.space4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
