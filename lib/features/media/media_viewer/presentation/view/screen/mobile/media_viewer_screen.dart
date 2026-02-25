import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/photo_info_panel.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/preview_media_grid.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/video_previewer.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/loading/chat_file_progress_indicator.dart';

import '../../../controller/media_viewer_controller.dart';
import '../../widget/photo_previewer.dart';
import '../../widget/video_info_panel.dart';

class MediaViewerScreen extends GetView<MediaViewerController> {
  final bool Function()? fullScreenToggle;
  final bool? showMediaListAndInfo;

  const MediaViewerScreen({
    super.key,
    this.fullScreenToggle,
    this.showMediaListAndInfo = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Material(
              color: Colors.transparent,
              child: ExtendedImageSlidePage(
                key: controller.slidePageKey,
                slideAxis: SlideAxis.vertical,
                slideType: SlideType.wholePage,
                slidePageBackgroundHandler: controller.slidePageBackgroundHandler,
                onSlidingPage: controller.onSlidingPage,
                resetPageDuration: const Duration(milliseconds: 200),
                child: InkWell(
                  onHover: controller.onHoveringMediaScreen,
                  onTap: controller.onPressedMediaScreen,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Positioned.fill(
                        child: Obx(() {
                          final show = controller.showMediaMenu();
                          return ExtendedImageGesturePageView.builder(
                            controller: controller.extendedPageController,
                            reverse: controller.shouldReverse,
                            onPageChanged: controller.onPageChange,
                            itemCount: controller.allMedias.length,
                            itemBuilder: (_, int index) {
                              final media = controller.allMedias[index];
                              final extensionMedia = media.url.split('.').last;
                              final heroTag = MediaViewerService.instance.generateMediaHeroTag(
                                openFrom: controller.openFrom,
                                heroTag: media.heroTag ?? media.url,
                              );

                              if (UChatConstant.supportVideoExtensionList.contains(extensionMedia.toLowerCase())) {
                                return VideoPreviewer(
                                  controllerTag: media.heroTag!,
                                  heroTag: heroTag,
                                  mediaUrl: media.url,
                                  videoThumbnailUrl: media.thumbnailPath ?? '',
                                  decryptedFile: media.decryptedFile,
                                  show: show,
                                );
                              } else {
                                return PhotoPreviewer(
                                  heroTag: heroTag,
                                  slidePagekey: controller.slidePageKey,
                                  mediaUrl: media.url,
                                  thumbnailUrl: media.thumbnailPath,
                                  decryptedFile: media.decryptedFile,
                                );
                              }
                            },
                          );
                        }),
                      ),

                      // Info panel
                      Positioned.fill(
                        child: Obx(() {
                          final currentMedia = controller.currentMediaFile();
                          if (currentMedia.isImage || currentMedia.isGif) {
                            return PhotoInfoPanel(
                              enableWarMode: controller.enableWarMode(),
                              show: controller.showMediaMenu(),
                              showMediaListAndInfo: showMediaListAndInfo,
                              media: currentMedia,
                              openFrom: controller.openFrom,
                              onClosePage: controller.onClosePage,
                              onGridPressed: controller.isBookmark ? null : controller.onPressedGrid,
                              onImageEdit: () => controller.handleEditImage(context, currentMedia),
                              mediaLength: controller.allMedias().length,
                              indexLength: controller.currentMediaIndex.value + 1,
                              onShare: () {
                                controller.handleShareMediaFile(currentMedia);
                              },
                              onDownload: () {
                                controller.handleDownloadAndSaveMedia(currentMedia);
                              },
                              onDelete: () {
                                controller.handleDeleteFromAlbum(currentMedia, context);
                              },
                              // onOpenMenu: _buildInfoPhoto(currentMedia, context)
                              onOpenMenu: (iconContext) async {},
                              previewWidget: _buildPreviewMedia(),
                            );
                          } else if (currentMedia.isVideo) {
                            if (controller.isSecretRoom) {
                              return VideoInfoPanel.secretRoom(
                                heroTag: currentMedia.heroTag!,
                                show: controller.showMediaMenu(),
                                media: currentMedia,
                                openFrom: controller.openFrom,
                                onClosePage: controller.onClosePage,
                              );
                            }
                            return VideoInfoPanel(
                              heroTag: currentMedia.heroTag!,
                              show: controller.showMediaMenu(),
                              media: currentMedia,
                              openFrom: controller.openFrom,
                              onClosePage: controller.onClosePage,
                              onGridPressed: controller.isBookmark ? null : controller.onPressedGrid,
                              mediaLength: controller.allMedias.length,
                              indexLength: controller.currentMediaIndex.value + 1,
                              onShare: () {
                                controller.handleShareMediaFile(currentMedia);
                              },
                              onDownload: () {
                                controller.handleDownloadAndSaveMedia(currentMedia);
                              },
                              onBookmarked: controller.isBookmark
                                  ? null
                                  : () {
                                      controller.bookmark();
                                    },
                              previewWidget: _buildPreviewMedia(),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _buildLoadingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Obx(() {
      if (controller.isDownloading()) {
        return PopScope(
          canPop: false,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.black54,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChatFileProgressIndicator(
                    progress: controller.downloadProgress.value,
                    showStopIcon: true,
                    sizeBox: 48,
                    indicatorRadius: 24,
                    outerLineWidth: 2,
                    isInfiniteLoading: controller.downloadProgress.value == 0,
                    onTap: () => controller.onCancelDownload(),
                    isShowBackgroundStopIcon: true,
                    stopIcon: Assets.vectors.xClose.svg(
                      colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      height: AppSize.size3,
                      width: AppSize.size3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    controller.downloadProgressFileSize,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildPreviewMedia() {
    if (showMediaListAndInfo == true) {
      return Obx(() {
        return PreviewMediaGrid(
          slidePagekey: controller.slidePageKey,
          // mediaUrl: '',
          openFrom: controller.openFrom,
          reverse: controller.shouldReverse,
          listController: controller.listController,
          scrollController: controller.scrollGridController,
          currentMediaIndex: controller.currentMediaIndex.value,
          show: controller.showMediaMenu.value,
          onTap: controller.onTapMediaItem,
          medias: controller.allMedias(), // controller.allMedias -> without () the ui will not update.
        );
      });
    }

    return const SizedBox.shrink();
  }
}
