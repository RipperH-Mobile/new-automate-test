import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart' as rive;
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview_controller.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/image/uchat_image.dart';

final _log = useLogger();

class StickerItemPreview extends StatelessWidget {
  final String packId;
  final String fileId;
  final bool enableFileSize;
  final double? width;
  final double? height;

  const StickerItemPreview({
    super.key,
    required this.packId,
    required this.fileId,
    this.enableFileSize = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StickerItemPreviewController>(
      key: ValueKey('$packId-$fileId'),
      init: StickerItemPreviewController(
        packId: packId,
        fileId: fileId,
      ),
      autoRemove: false,
      assignId: true,
      tag: '$packId-$fileId',
      builder: (ctl) {
        if (ctl.isLoading) {
          return SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }

        final errorWidget = GestureDetector(
          onTap: ctl.downloadSticker,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundDisable,
              borderRadius: const BorderRadius.all(Radius.circular(AppRadius.roundedLg)),
            ),
            child: Center(
              child: Icon(
                Icons.error,
                color: context.theme.appColors.iconDisable,
              ),
            ),
          ),
        );

        if (packId.isEmpty || fileId.isEmpty) {
          return errorWidget;
        }

        final stickerFile = ctl.stickerFile;

        if (ctl.isError || stickerFile == null) {
          return errorWidget;
        }

        if (ctl.isLottieFile) {
          return _buildStickerWithSizeOverlay(
            child: RepaintBoundary(
              child: SizedBox(
                width: width,
                height: height,
                child: Lottie.file(
                  stickerFile,
                  key: ValueKey('lottie-animation-${ctl.packId}-${ctl.fileId}'),
                  fit: BoxFit.contain,
                  renderCache: RenderCache.drawingCommands,
                  errorBuilder: (context, error, stackTrace) {
                    _log.w('Error loading Lottie file: $error', error, stackTrace);
                    return errorWidget;
                  },
                ),
              ),
            ),
            controller: ctl,
          );
        }

        if (ctl.isRiveFile && ctl.riveFile != null) {
          return _buildStickerWithSizeOverlay(
            child: RepaintBoundary(
              child: SizedBox(
                width: width,
                height: height,
                child: rive.RiveAnimation.direct(
                  key: ValueKey('rive-animation-${ctl.packId}-${ctl.fileId}'),
                  ctl.riveFile!,
                  fit: BoxFit.cover,
                  useArtboardSize: true,
                  speedMultiplier: ctl.riveSpeedPlay.toDouble(),
                  placeHolder: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
            controller: ctl,
          );
        }

        if (ctl.isFileExist) {
          return _buildStickerWithSizeOverlay(
            child: RepaintBoundary(
              child: SizedBox(
                width: width,
                height: height,
                child: Image.file(
                  stickerFile,
                  key: ValueKey('sticker-image-${ctl.packId}-${ctl.fileId}'),
                  fit: BoxFit.contain,
                  width: width,
                  height: height,
                  cacheHeight: width?.cacheSize ?? 60.cacheSize,
                  errorBuilder: (context, error, stackTrace) {
                    return errorWidget;
                  },
                ),
              ),
            ),
            controller: ctl,
          );
        } else {
          return _buildStickerWithSizeOverlay(
            child: RepaintBoundary(
              child: SizedBox(
                width: width,
                height: height,
                child: UChatImage.network(
                  FileService.instance.getStickerUrl(fileId, packId),
                  key: ValueKey('sticker-network-${ctl.packId}-${ctl.fileId}'),
                  fit: BoxFit.contain,
                  width: width,
                  height: height,
                  cacheHeight: height?.cacheSize ?? 60.cacheSize,
                  customLoadingWidget: (state) {
                    if (state.extendedImageLoadState == LoadState.loading) {
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    } else if (state.extendedImageLoadState == LoadState.failed) {
                      return errorWidget;
                    }

                    return state.completedWidget;
                  },
                  customErrorWidget: (state) {
                    return errorWidget;
                  },
                ),
              ),
            ),
            controller: ctl,
          );
        }
      },
    );
  }

  /// Helper method to build sticker with file size overlay
  Widget _buildStickerWithSizeOverlay({
    required Widget child,
    required StickerItemPreviewController controller,
  }) {
    final fileSize = controller.formattedFileSize;

    if (fileSize == null || enableFileSize != true || !controller.enableWarMode()) {
      return child;
    }

    return Stack(
      children: [
        child,
        Positioned(
          top: 4,
          right: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              children: [
                Text(
                  fileSize,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'WH',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${controller.imageWidth}*${controller.imageHeight}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
