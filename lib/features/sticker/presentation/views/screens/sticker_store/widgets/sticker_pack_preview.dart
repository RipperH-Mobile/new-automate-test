import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/abstracts/sticker_pack_entity.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_price.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerPackPreview extends StatelessWidget {
  final StickerPackEntity pack;
  final bool isVertical;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const StickerPackPreview({
    super.key,
    required this.pack,
    this.isVertical = true,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 112.spMin,
          color: Colors.transparent,
          padding: const EdgeInsets.only(right: AppSpace.space3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StickerItemPreview(
                packId: pack.id,
                fileId: pack.coverId,
                width: 112.spMin,
                height: 112.spMin,
              ),
              AppSpace.space2.verticalSpace,
              Expanded(
                child: AppText.body3(
                  pack.name,
                  context: context,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  useAutoSizeText: true,
                ),
              ),
              AppSpace.space2.verticalSpace,
              StickerPrice(
                price: pack.price,
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 96,
          color: Colors.transparent,
          padding: const EdgeInsets.only(left: AppSpace.space4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StickerItemPreview(
                packId: pack.id,
                fileId: pack.coverId,
                width: 88.spMin,
                height: 88.spMin,
              ),
              AppSpace.space4.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpace.space4),
                      child: AppText.body1(
                        pack.name,
                        context: context,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    AppSpace.space05.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpace.space4),
                      child: AppText.body3(
                        pack.publisher,
                        context: context,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        color: context.theme.appColors.textLight,
                      ),
                    ),
                    AppSpace.space2.verticalSpace,
                    StickerPrice(
                      price: pack.price,
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 10.spMin,
                      width: double.infinity,
                      child: Divider(
                        color: context.theme.appColors.border,
                        height: 1.spMin,
                        thickness: 1.spMin,
                      ),
                    ),
                  ],
                ),
              ),
              if (onDelete != null)
                IconButton.filled(
                  onPressed: onDelete,
                  icon: Assets.vectors.iconClearSearchBox.svg(),
                ),
            ],
          ),
        ),
      );
    }
  }
}
