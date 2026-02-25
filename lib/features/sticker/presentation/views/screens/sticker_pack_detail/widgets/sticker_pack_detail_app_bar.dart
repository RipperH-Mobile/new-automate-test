import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_pack_detail_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerPackDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StickerPackDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: Get.back,
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  const Set<WidgetState> interactiveStates = <WidgetState>{
                    WidgetState.pressed,
                    WidgetState.hovered,
                    WidgetState.focused,
                  };
                  if (states.any(interactiveStates.contains)) {
                    return Colors.black.withValues(alpha: 0.4);
                  }

                  return const Color(0xFFC4C4C4);
                }),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSpace.space2.horizontalSpace,
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: context.theme.appColors.iconPrimary,
                  ),
                  AppSpace.space2.horizontalSpace,
                  AppText.button1(
                    'Back'.tr,
                    context: context,
                    color: context.theme.appColors.textPrimary,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GetBuilder<StickerPackDetailController>(
              id: StickerPackDetailIds.likeButton,
              tag: Get.parameters['stickerPackId'],
              builder: (ctl) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LikeButton(
                        size: AppSize.size6.spMin,
                        onTap: ctl.isLoadingStickerDetail ? null : ctl.onTapHeartButton,
                        isLiked: ctl.isFavorite,
                        likeBuilder: (bool isLiked) {
                          if (isLiked) {
                            return Assets.vectors.heartFilled.svg(height: AppSize.size6.spMin);
                          }

                          return Assets.vectors.heart.svg(height: AppSize.size6.spMin);
                        },
                      ),
                      AppSpace.space4.horizontalSpace,
                      GestureDetector(
                        onTap: ctl.onTapShareButton,
                        child: Assets.vectors.shareArrowUpIcon.svg(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
