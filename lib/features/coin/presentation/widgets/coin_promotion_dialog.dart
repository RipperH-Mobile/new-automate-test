import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/collections/announcement_collection.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';

class CoinPromotionDialog extends StatelessWidget {
  final AnnouncementCollection coinPromotion;
  final void Function()? onPressDoNotShow;

  const CoinPromotionDialog({super.key, required this.coinPromotion, this.onPressDoNotShow});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: context.theme.appColors.backgroundGrayLightestPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.rounded3xl)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: ColoredBox(
                color: context.theme.appColors.backgroundNeutralLight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Promotion image
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: coinPromotion.image != null
                          ? AspectRatio(
                              aspectRatio: 3 / 4,
                              child: UChatImage.network(
                                FileService().getAnnounceUrl(coinPromotion.getImage(Get.locale?.languageCode ?? 'EN')),
                                fit: BoxFit.fitHeight,
                                cache: true,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),

                    // Close button
                    Positioned(
                      top: AppSpace.space4,
                      right: AppSpace.space4,
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 24.w,
                          width: 24.w,
                          decoration: BoxDecoration(
                            color: context.theme.appColors.backgroundSystemMessage.withValues(alpha: .52),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.close,
                            size: 16.sp,
                            color: context.theme.appColors.iconPrimaryInverse,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Do not show again button
          GestureDetector(
            onTap: () {
              if (onPressDoNotShow != null) {
                onPressDoNotShow!();
              } else {
                Get.back();
              }
            },
            child: Container(
              height: 42.h,
              alignment: Alignment.center,
              color: context.theme.appColors.backgroundGrayLightest,
              child: AppText.body4(
                'Don\'t show again for today'.tr,
                context: context,
                color: context.theme.appColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
