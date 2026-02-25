import 'dart:async';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu_widget_expanded.dart' as custom_context_menu;
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/media_gallery/presentation/controller/media_gallery_controller.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_context_menu.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class MediaGallerySelectableAssetView extends StatelessWidget {
  final AssetEntity asset;

  final double? previewHeight;

  final double? previewWidth;

  final bool showCheckBox;

  final int selectedIndex;

  final FutureOr<void> Function(AssetEntity asset)? onSelected;
  final FutureOr<void> Function(AssetEntity asset)? onSent;
  final FutureOr<void> Function(AssetEntity asset)? onEdit;
  final FutureOr<void> Function(AssetEntity asset)? onSendSample;

  final bool isAvailable;
  final bool? enableWarMode;

  const MediaGallerySelectableAssetView({
    super.key,
    required this.asset,
    this.previewHeight,
    this.previewWidth,
    this.showCheckBox = true,
    this.onSelected,
    this.onSent,
    this.onEdit,
    this.selectedIndex = -1,
    this.isAvailable = true,
    this.enableWarMode,
    this.onSendSample,
  });

  bool get isSelected => selectedIndex != -1;

  List<Widget> _contextMenuActions(BuildContext context) => [
        MediaGalleryContextMenu(
          parentContext: context,
          text: selectedIndex == -1 ? 'Select'.tr : 'Unselect'.tr,
          onTap: () {
            onSelected?.call(asset);
            Get.back();
          },
          tailing: Assets.vectors.checkCircle.svg(
            colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
          ),
        ),
        if (asset.type == AssetType.image && onEdit != null && enableWarMode == true)
          MediaGalleryContextMenu(
            parentContext: context,
            text: 'Edit'.tr,
            onTap: () {
              onEdit?.call(asset);
              Get.back();
            },
            tailing: Assets.vectors.editedIcon.svg(
              colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
              width: 20.spMin,
              height: 20.spMin,
            ),
          ),
        MediaGalleryContextMenu(
          parentContext: context,
          text: 'Send'.tr,
          onTap: () {
            onSent?.call(asset);
            Get.back();
          },
          tailing: Assets.vectors.send.svg(
            colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
            width: 20.spMin,
            height: 20.spMin,
          ),
        ),
        MediaGalleryContextMenu(
          parentContext: context,
          text: 'Close'.tr,
          isWarningMenu: true,
          onTap: () {
            Get.back();
          },
          tailing: Assets.vectors.xClose.svg(
            colorFilter: ColorFilter.mode(context.theme.appColors.iconError, BlendMode.srcIn),
            width: 20.spMin,
            height: 20.spMin,
          ),
        ),
        if (UserController.instance.enableTroubleshoot)
          MediaGalleryContextMenu(
            parentContext: context,
            text: 'Send Sample'.tr,
            isWarningMenu: true,
            onTap: () {
              Get.back();
              onSendSample?.call(asset);
            },
            tailing: const SizedBox.shrink(),
          ),
      ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected?.call(asset);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth == 0 || constraints.maxHeight == 0) {
                return const SizedBox.shrink();
              }
              return custom_context_menu.CupertinoContextMenu.builder(
                onJustTap: () {
                  onSelected?.call(asset);
                },
                actions: _contextMenuActions(context),
                builder: (context, animation) {
                  double width = previewWidth ?? constraints.maxWidth;
                  double height = previewHeight ?? constraints.maxHeight;

                  AssetEntityImageProvider imageProvider = AssetEntityImageProvider(
                    asset,
                    isOriginal: false,
                    thumbnailSize: ThumbnailSize(width.cacheSize, height.cacheSize),
                  );

                  if (animation.value > .7) {
                    width = Get.width * 0.8;
                    height = Get.height * 0.6;
                    final aspectRatio = asset.width / asset.height;
                    imageProvider = AssetEntityImageProvider(
                      asset,
                      isOriginal: false,
                      thumbnailSize: ThumbnailSize(width.cacheSize, height.cacheSize),
                    );

                    return RepaintBoundary(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: AppSpace.space10,
                            left: AppSpace.space6,
                            right: AppSpace.space6,
                          ),
                          child: AspectRatio(
                            aspectRatio: aspectRatio,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                              child: ExtendedImage(
                                key: ValueKey('media_gallery_asset_view-${asset.id}'),
                                image: imageProvider,
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.high,
                                loadStateChanged: (state) {
                                  switch (state.extendedImageLoadState) {
                                    case LoadState.loading:
                                      return ShimmerLoading(
                                        enable: true,
                                        baseColor: context.theme.appColors.backgroundNeutralLight,
                                        highlightColor: context.theme.appColors.backgroundNeutralLightest,
                                        child: Container(
                                          color: Colors.blue.shade100,
                                          width: width,
                                          height: height,
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
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  return ExtendedImage(
                    key: ValueKey('media_gallery_asset_view-${asset.id}'),
                    image: ExtendedResizeImage(imageProvider),
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                    filterQuality: FilterQuality.low,
                    loadStateChanged: (state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.loading:
                          return Container(
                            color: context.theme.appColors.backgroundNeutralLight,
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
                  );
                },
              );
            },
          ),

          // Show duration for video
          if (asset.type == AssetType.video)
            Positioned(
              right: AppSpace.space2,
              bottom: AppSpace.space2,
              child: RepaintBoundary(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.space2,
                        vertical: AppSpace.space05,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFF0E1216).withValues(alpha: .8),
                            const Color(0xFF333942).withValues(alpha: .8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                      ),
                      child: Text(
                        asset.duration.toDurationStr,
                        style: context.theme.appTexts.body4.copyWith(
                          fontSize: 10,
                          color: context.theme.appColors.textPrimaryInverse,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          if (isSelected)
            Positioned(
              child: ColoredBox(
                color: context.theme.appColors.backgroundDarkNeutral.withValues(alpha: 0.5),
              ),
            ),
          // Show checkbox if needed
          if (showCheckBox && isAvailable)
            Positioned(
              top: AppSpace.space2,
              right: AppSpace.space2,
              child: Container(
                width: 28.spMin,
                height: 28.spMin,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.theme.appColors.backgroundPrimary
                      : context.theme.appColors.backgroundNeutralLightPressed.withValues(alpha: .32),
                  shape: BoxShape.circle,
                  border: isSelected
                      ? null
                      : Border.all(
                          color: context.theme.appColors.borderLight,
                          width: 1,
                        ),
                ),
                child: Builder(
                  builder: (context) {
                    if (!isSelected) {
                      return const SizedBox.shrink();
                    }

                    return Center(
                      child: AppText.body3Bold(
                        '${selectedIndex + 1}',
                        context: context,
                        color: context.theme.appColors.textPrimaryInverse,
                      ),
                    );
                  },
                ),
              ),
            ),
          if (!isAvailable)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.4),
                child: Center(
                  child: Assets.vectors.warning.svg(
                    width: 30.spMin,
                    height: 30.spMin,
                    colorFilter: ColorFilter.mode(
                      context.theme.appColors.iconError,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),

          // Download progress for asset from cloud
          GetBuilder<MediaGalleryController>(
            id: MediaGalleryIds.downloadProgressId(asset.id),
            builder: (ctl) {
              final downloadProgress = ctl.downloadFileFromCloudMap[asset.id];

              if (downloadProgress == null) {
                return const SizedBox.shrink();
              }

              if (downloadProgress <= 0) {
                return RepaintBoundary(
                  child: Container(
                    width: 45.spMin,
                    height: 45.spMin,
                    padding: const EdgeInsets.all(AppSpace.space2),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      valueColor: AlwaysStoppedAnimation<Color>(context.theme.appColors.textPrimaryInverse),
                    ),
                  ),
                );
              }

              return RepaintBoundary(
                child: Container(
                  width: 45.spMin,
                  height: 45.spMin,
                  padding: const EdgeInsets.all(AppSpace.space2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                  child: CircularProgressIndicator(
                    value: downloadProgress,
                    strokeCap: StrokeCap.round,
                    valueColor: AlwaysStoppedAnimation<Color>(context.theme.appColors.textPrimaryInverse),
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
