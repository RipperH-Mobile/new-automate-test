import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_store_controller.dart';
import 'package:uchat/features/sticker/presentation/views/screens/sticker_store/widgets/sticker_pack_preview.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class StickerStorePreviewCategory extends StatelessWidget {
  final String categoryName;
  final List<StoreStickerPackEntity> stickerPacks;
  final VoidCallback? onSeeAll;

  const StickerStorePreviewCategory({
    super.key,
    required this.categoryName,
    required this.stickerPacks,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.subtitle1(
                  categoryName,
                  context: context,
                ),
                GestureDetector(
                  onTap: onSeeAll,
                  child: AppText.body3Bold(
                    'See all'.tr,
                    context: context,
                    color: context.theme.appColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<StickerStoreController>(
            id: StickerStoreIds.stickerPackPreviewList,
            builder: (controller) {
              if (controller.isLoadingStore) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
                  child: SizedBox(
                    height: 0.2.sh,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSpace.space3),
                          child: ShimmerLoading(
                            enable: true,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 112.spMin,
                                  height: 112.spMin,
                                  decoration: BoxDecoration(
                                    color: context.theme.appColors.backgroundNeutralLight,
                                    borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                                  ),
                                ),
                                AppSpace.space2.verticalSpace,
                                Container(
                                  width: 90.spMin,
                                  height: 12.spMin,
                                  decoration: BoxDecoration(
                                    color: context.theme.appColors.backgroundNeutralLight,
                                    borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                                  ),
                                ),
                                AppSpace.space1.verticalSpace,
                                Container(
                                  width: 60.spMin,
                                  height: 12.spMin,
                                  decoration: BoxDecoration(
                                    color: context.theme.appColors.backgroundNeutralLight,
                                    borderRadius: BorderRadius.circular(AppRadius.rounded3xl),
                                  ),
                                ),
                                AppSpace.space1.verticalSpace,
                                Container(
                                  width: 80.spMin,
                                  height: 20.spMin,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded3xl)),
                                    color: context.theme.appColors.backgroundNeutralLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),
                child: SizedBox(
                  height: 0.2.sh,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                    itemCount: stickerPacks.length,
                    itemBuilder: (context, index) {
                      final stickerPack = stickerPacks[index];
                      return StickerPackPreview(
                        pack: stickerPack,
                        onTap: () => controller.onGoToStickerDetail(stickerPackId: stickerPack.id),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
