import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';

class StickerPackListItem extends StatelessWidget {
  final String title;
  final String packId;
  final String fileId;
  final VoidCallback onPressed;
  final String? subtitle;
  final Widget? customSubtitle;
  final bool hasTopBorderRadius;
  final bool hasBottomBorderRadius;
  final bool hasDivider;

  const StickerPackListItem({
    super.key,
    required this.title,
    required this.packId,
    required this.fileId,
    required this.onPressed,
    this.subtitle,
    this.customSubtitle,
    this.hasTopBorderRadius = true,
    this.hasBottomBorderRadius = true,
    this.hasDivider = false,
  }) : assert(
          subtitle == null || customSubtitle == null,
          'Only one of subtitle or customSubtitle can be provided.',
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: AppSize.size24,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.space1),
              child: StickerItemPreview(
                packId: packId,
                fileId: fileId,
                width: AppSize.size20,
                height: AppSize.size20,
              ),
            ),
            AppSpace.space4.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: AppSpace.space015,
                            ),
                            Container(
                              // Constraint to prevent text overflow.
                              // AppSize 20 is the width of the sticker item preview.
                              // AppSpace.space4 * 5 is the horizontal padding of the list item.
                              //    1.padding on the left side of the white box.
                              //    2.padding on the left side of the sticker preview.
                              //    3.padding on the right side of the sticker preview.
                              //    4.padding on the right side of the text.
                              //    5.padding on the right side of the white box.
                              // and all this padding is space4 so it become space4 * 5
                              constraints: BoxConstraints(maxWidth: Get.width - AppSpace.space4 * 5 - AppSize.size20),
                              child: Text(
                                title,
                                style: context.theme.appTexts.body1.copyWith(
                                  color: context.theme.appColors.textDarkest,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            AppSpace.space1.verticalSpace,
                            if (subtitle != null)
                              Container(
                                // Constraint to prevent text overflow.
                                // AppSize 20 is the width of the sticker item preview.
                                // AppSpace.space4 * 5 is the horizontal padding of the list item.
                                //    1.padding on the left side of the white box.
                                //    2.padding on the left side of the sticker preview.
                                //    3.padding on the right side of the sticker preview.
                                //    4.padding on the right side of the text.
                                //    5.padding on the right side of the white box.
                                // and all this padding is space4 so it become space4 * 5
                                constraints: BoxConstraints(maxWidth: Get.width - AppSpace.space4 * 5 - AppSize.size20),
                                child: Text(
                                  subtitle!,
                                  style: context.theme.appTexts.body3.copyWith(
                                    color: context.theme.appColors.textLight,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            if (customSubtitle != null)
                              Container(
                                // Constraint to prevent text overflow.
                                // AppSize 20 is the width of the sticker item preview.
                                // AppSpace.space4 * 5 is the horizontal padding of the list item.
                                //    1.padding on the left side of the white box.
                                //    2.padding on the left side of the sticker preview.
                                //    3.padding on the right side of the sticker preview.
                                //    4.padding on the right side of the text.
                                //    5.padding on the right side of the white box.
                                // and all this padding is space4 so it become space4 * 5
                                constraints: BoxConstraints(maxWidth: Get.width - AppSpace.space4 * 5 - AppSize.size20),
                                child: customSubtitle!,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (hasDivider)
                    Container(
                      color: context.theme.appColors.border,
                      height: AppSize.sizePx,
                      width: double.infinity,
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
