import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/features/media_gallery/presentation/controller/media_gallery_controller.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_selectable_asset_view.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/app_text.dart';

class MediaGalleryGrid extends StatelessWidget {
  const MediaGalleryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MediaGalleryController>(
      id: MediaGalleryIds.mainMediaGalleryId,
      builder: (ctl) {
        if (ctl.isLoadingInitAssets && ctl.itemCount == 0) {
          return GridView.builder(
            controller: ctl.gridViewScrollController,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            padding: EdgeInsets.only(bottom: ctl.gridViewBottomHeight.toDouble()),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSpace.space05,
              mainAxisSpacing: AppSpace.space05,
            ),
            cacheExtent: 200.0,
            itemCount: 40,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: context.theme.appColors.backgroundNeutralLight,
                highlightColor: context.theme.appColors.backgroundNeutralLightest,
                child: Container(
                  color: Colors.blue.shade100,
                  child: const SizedBox.shrink(),
                ),
              );
            },
          );
        }

        if (ctl.itemCount == 0 && !ctl.isLoadingInitAssets) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Assets.images.noImage.image(
                    color: Colors.grey.shade300,
                    height: 80.spMin,
                    width: 80.spMin,
                    cacheHeight: 80.cacheSize,
                    fit: BoxFit.cover,
                  ),
                ),
                AppSpace.space4.verticalSpace,
                AppText.body1('No Content'.tr, context: context),
              ],
            ),
          );
        }

        return GridView.builder(
          controller: ctl.gridViewScrollController,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          padding: EdgeInsets.only(bottom: ctl.gridViewBottomHeight.toDouble()),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ctl.gridColumn,
            crossAxisSpacing: AppSpace.space05,
            mainAxisSpacing: AppSpace.space05,
          ),
          cacheExtent: 200.0,
          itemCount: ctl.itemCount,
          itemBuilder: (context, index) {
            if (ctl.isLoadingInitAssets) {
              return Shimmer.fromColors(
                baseColor: context.theme.appColors.backgroundNeutralLight,
                highlightColor: context.theme.appColors.backgroundNeutralLightest,
                child: Container(
                  color: Colors.blue.shade100,
                  child: const SizedBox.shrink(),
                ),
              );
            }

            final asset = ctl.currentAssets[index];

            return RepaintBoundary(
              child: GetBuilder<MediaGalleryController>(
                id: MediaGalleryIds.galleryAssetsId(asset.id),
                builder: (ctl) {
                  return MediaGallerySelectableAssetView(
                    enableWarMode: ctl.enableWarMode(),
                    asset: asset,
                    previewHeight: ctl.previewSize,
                    previewWidth: ctl.previewSize,
                    showCheckBox: !ctl.onlyOneSelectable,
                    selectedIndex: ctl.selectedAssetIndex(asset),
                    isAvailable: ctl.isAvailableAsset(asset),
                    onSendSample: ctl.onSendSample,
                    onSent: (asset) {
                      //NOTE. only one image sent when long press
                      final result = MediaGalleryResult.fromAssets([asset]);
                      if (ctl.onDoneCallback != null) {
                        ctl.onDoneCallback!(result);
                      } else {
                        Get.back<MediaGalleryResult>(result: result);
                      }
                    },
                    onEdit: (asset) => ctl.handleEditImage(asset, context),
                    onSelected: (asset) {
                      if (ctl.onlyOneSelectable) {
                        ctl.onSelectedAssetAndSend(asset, context);
                        return;
                      } else {
                        ctl.onSelectedAsset(asset, context);
                      }
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
