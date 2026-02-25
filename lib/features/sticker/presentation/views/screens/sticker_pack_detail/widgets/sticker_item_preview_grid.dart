import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_pack_detail_controller.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class StickerItemPreviewGrid extends StatelessWidget {
  const StickerItemPreviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StickerPackDetailController>(
      id: StickerPackDetailIds.itemGrid,
      tag: Get.parameters['stickerPackId'] ?? '',
      builder: (ctl) {
        if (ctl.isLoadingStickerDetail) {
          return ShimmerLoading(
            enable: true,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 4,
              ),
              itemCount: 20,
              itemBuilder: (_, index) {
                return Container(
                  height: 96.spMin,
                  width: 96.spMin,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                  ),
                );
              },
            ),
          );
        }

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 4,
          ),
          itemCount: ctl.stickerPack?.stickerItems.length ?? 0,
          itemBuilder: (_, index) {
            final stickerPack = ctl.stickerPack;
            if (stickerPack == null || stickerPack.stickerItems.isEmpty) {
              return const SizedBox.shrink();
            }

            final item = stickerPack.stickerItems[index];
            double opacity = 1;
            if (ctl.selectedFileId.isNotEmpty) {
              if (ctl.selectedFileId == item.fileId) {
                opacity = 1;
              } else {
                opacity = 0.5;
              }
            }

            double animateScale = .9;
            if (ctl.selectedFileId.isNotEmpty) {
              if (ctl.selectedFileId == item.fileId) {
                animateScale = 1;
              }
            }

            return GestureDetector(
              onTap: () {
                ctl.onTapSticker(item.fileId);
              },
              child: StickerItemPreview(
                enableFileSize: ctl.enableWarMode.value,
                width: 96.spMin,
                height: 96.spMin,
                packId: stickerPack.id,
                fileId: item.fileId,
              ).animate(value: 1, target: opacity).fade(duration: 300.ms),
            ).animate(value: .9, target: animateScale).scale(duration: 1000.ms);
          },
        );
      },
    );
  }
}
