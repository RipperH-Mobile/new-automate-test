import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';

class MediaGalleryAssetView extends StatelessWidget {
  final AssetEntity asset;

  final double? previewHeight;
  final double? previewWidth;
  final double? borderRadius;

  const MediaGalleryAssetView({
    super.key,
    required this.asset,
    this.previewHeight,
    this.previewWidth,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.roundedMd),
      child: ExtendedImage(
        key: ValueKey('media_gallery_album_cover-${asset.id}'),
        image: ExtendedResizeImage(
          AssetEntityImageProvider(
            asset,
            isOriginal: false,
            thumbnailSize: previewHeight != null && previewWidth != null ? ThumbnailSize.square(420.cacheSize) : null,
          ),
        ),
        gaplessPlayback: true,
        clearMemoryCacheWhenDispose: false,
        fit: BoxFit.cover,
        width: previewWidth,
        height: previewHeight,
        filterQuality: FilterQuality.medium,
        loadStateChanged: (state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return Shimmer.fromColors(
                baseColor: context.theme.appColors.backgroundNeutralLight,
                highlightColor: context.theme.appColors.backgroundNeutralLighter,
                child: Container(
                  color: context.theme.appColors.backgroundNeutralLightPressed,
                ),
              );
            case LoadState.failed:
              return Container(
                color: context.theme.appColors.backgroundNeutralLightPressed,
                child: Center(
                  child: Assets.vectors.photoOutlined.svg(),
                ),
              );
            case LoadState.completed:
              return state.completedWidget;
          }
        },
      ),
    );
  }
}
