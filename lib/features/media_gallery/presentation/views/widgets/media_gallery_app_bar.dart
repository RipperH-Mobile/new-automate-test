import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/media_gallery/domain/model/album_asset_model.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_asset_view.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/features/media_gallery/presentation/controller/media_gallery_controller.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';
import 'package:uchat/widgets/popover_menu/uchat_popover.dart';
import 'package:uchat/widgets/popover_menu/widgets/pop_over_menu_item.dart';

class MediaGalleryAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showDragHandle;

  final MediaGalleryAppBarActionType appBarActionType;

  final bool isShowCloseButton;

  final double height;

  final void Function(double inversePositionDy)? onVerticalPositionUpdate;

  final void Function(double inversePositionDy)? onVerticalDragEnd;
  final bool disableSafeArea;

  const MediaGalleryAppBar({
    super.key,
    this.showDragHandle = true,
    this.appBarActionType = MediaGalleryAppBarActionType.close,
    this.isShowCloseButton = true,
    this.height = 72,
    this.onVerticalPositionUpdate,
    this.onVerticalDragEnd,
    this.disableSafeArea = false,
  });

  @override
  State<MediaGalleryAppBar> createState() => _MediaGalleryAppBarState();

  @override
  Size get preferredSize {
    return Size.fromHeight(height.spMin);
  }
}

class _MediaGalleryAppBarState extends State<MediaGalleryAppBar> {
  bool fullScreen = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: fullScreen || !widget.disableSafeArea,
      bottom: false,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragUpdate: (details) {
          double positionY = details.globalPosition.dy;
          final position = 1.sh - positionY;
          final value = 1.sh - positionY;
          if (value >= 0.6.sh != fullScreen) {
            setState(() {
              fullScreen = value >= 0.6.sh;
            });
          }
          widget.onVerticalPositionUpdate?.call(position);
        },
        onVerticalDragEnd: (details) {
          double positionY = details.globalPosition.dy;
          final value = 1.sh - positionY;
          widget.onVerticalDragEnd?.call(value);
        },
        child: Container(
          height: 70,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Bar of the box
              if (widget.showDragHandle)
                Positioned(
                  top: AppSpace.space2,
                  child: Container(
                    width: 48.spMin,
                    height: 5.spMin,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.borderDisable,
                      borderRadius: BorderRadius.circular(AppRadius.roundedFull),
                    ),
                  ),
                ),

              // Close button
              if (widget.appBarActionType == MediaGalleryAppBarActionType.close && widget.isShowCloseButton)
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      Get.back();
                    },
                    child: AppText.body1(
                      'Close'.tr,
                      context: context,
                      color: context.theme.appColors.textPrimary,
                    ),
                  ),
                ),

              // Back button
              if (widget.appBarActionType == MediaGalleryAppBarActionType.back)
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () async {
                      Get.back();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Assets.vectors.chevronBackIos.svg(
                          height: AppSize.size6,
                          width: AppSize.size6,
                          colorFilter: ColorFilter.mode(
                            context.theme.appColors.textPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                        AppText.button1(
                          'Back'.tr,
                          context: context,
                          color: context.theme.appColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ),

              // Album name and select all button
              Builder(
                builder: (contextDropdown) {
                  return GetBuilder<MediaGalleryController>(
                    id: MediaGalleryIds.albumSelectionBuildId,
                    builder: (ctl) {
                      if (ctl.isLoadingAlbumList) {
                        return Shimmer.fromColors(
                          baseColor: context.theme.appColors.backgroundNeutralLight,
                          highlightColor: context.theme.appColors.backgroundNeutralLighter,
                          child: Container(
                            height: 40.spMin,
                            width: 100.spMin,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppRadius.roundedMd),
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          final albums = ctl.albumAssetList;

                          final shouldLoadAdditionalInfo = albums.any((album) => album.isFetchedAdditional == false);
                          if (shouldLoadAdditionalInfo) {
                            ctl.getAllAdditionalAlbumInfo();
                          }
                          _openAlbums(context: contextDropdown, albums: albums, onBack: ctl.onSelectedAlbum);
                        },
                        child: SizedBox(
                          height: 56.spMin,
                          width: 150.spMin,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppText.title3(ctl.currentAlbum?.albumName ?? 'Recents'.tr, context: context),
                              AppSpace.space1.horizontalSpace,
                              if (ctl.albumAssetList.length > 1) Assets.vectors.arrowDown.svg(),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Size get preferredSize {
    return Size.fromHeight(widget.height.spMin);
  }

  Future<void> _openAlbums({
    required BuildContext context,
    required List<AlbumAssetModel> albums,
    required Function(AlbumAssetModel) onBack,
  }) {
    List<PopoverMenuItem> widgetItems = [];
    for (final album in albums) {
      final albumId = album.albumId;
      widgetItems.add(
        PopoverMenuItem(
          onPressed: (BuildContext context) async {
            Navigator.pop(context);
            onBack.call(album);
          },
          hasBottomDivider: true,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.body2(
                      album.albumName,
                      context: context,
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                    GetBuilder<MediaGalleryController>(
                      id: MediaGalleryIds.albumMenuId,
                      builder: (ctl) {
                        if (ctl.isLoadingAdditionalAlbumInfo) {
                          return Shimmer.fromColors(
                            baseColor: context.theme.appColors.backgroundNeutralLight,
                            highlightColor: context.theme.appColors.backgroundNeutralLightest,
                            child: Container(
                              height: 14.spMin,
                              width: 40.spMin,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppRadius.roundedMd),
                                color: Colors.white,
                              ),
                            ),
                          );
                        }

                        final currentAlbum = ctl.albumAssetList.firstWhere((element) => element.albumId == albumId);

                        return AppText.caption1(
                          currentAlbum.totalAssets.toString(),
                          context: context,
                          color: context.theme.appColors.textLighter,
                        );
                      },
                    ),
                  ],
                ),
              ),
              GetBuilder<MediaGalleryController>(
                id: MediaGalleryIds.albumMenuId,
                builder: (ctl) {
                  if (ctl.isLoadingAdditionalAlbumInfo) {
                    return Shimmer.fromColors(
                      baseColor: context.theme.appColors.backgroundNeutralLight,
                      highlightColor: context.theme.appColors.backgroundNeutralLightest,
                      child: Container(
                        width: 36.spMin,
                        height: 36.spMin,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.roundedMd),
                          color: Colors.white,
                        ),
                      ),
                    );
                  }

                  final currentAlbum = ctl.albumAssetList.firstWhere((element) => element.albumId == albumId);

                  if (currentAlbum.totalAssets == 0) {
                    return const SizedBox.shrink();
                  }

                  return MediaGalleryAssetView(
                    asset: currentAlbum.firstAsset!,
                    previewWidth: 36.spMin,
                    previewHeight: 36.spMin,
                  );
                },
              ),
            ],
          ),
        ),
      );
    }

    return UChatPopover.open(
      context: context,
      contentDxOffset: 10.spMin,
      contentDyOffset: -10.spMin,
      width: 196.spMin,
      maxHeight: 265.spMin,
      menu: widgetItems,
    );
  }
}
