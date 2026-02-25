import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/presentation/controllers/thumbnail_bytes_cache_manager.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_image_preview/message_local_image_provider.dart';
import 'package:uchat/utils/blurhash.dart';
import 'package:uchat/utils/uchat_image.dart';

/// Image message element local
///
/// This widget is used to display the image message element locally, that from camera (File) or gallery (AssetEntity)
class MessageImageElementLocal extends StatelessWidget {
  /// The reference file
  ///
  /// This value is used to determine the reference file
  ///
  /// `Default value is null`
  final String? refFile;

  /// The file path
  ///
  /// This value is used to determine the file path to load the image from local storage
  ///
  /// `Default value is null`
  final String? filePath;

  /// The file bytes
  ///
  /// This value is used to determine the file bytes to load the image from memory
  ///
  /// This is used when the file type is video
  ///
  /// `Default value is null`
  final Uint8List? fileBytes;

  /// The file type
  ///
  /// This value is used to determine the file type
  ///
  /// Now only support image and video
  ///
  /// `Default value is MessageFileType.image`
  final MessageFileType fileType;

  /// The image width
  ///
  /// This value is used to determine the image width
  /// - For image, this value is the image width
  /// - For video, this value is the thumbnail width
  final double imageWidth;

  /// The image height
  ///
  /// This value is used to determine the image height
  /// - For image, this value is the image height
  /// - For video, this value is the thumbnail height
  final double imageHeight;

  /// The blurhash
  final String? blurhash;

  /// The file asset id
  ///
  /// This value is used to determine the file asset id to load the image from asset entity (gallery)
  ///
  /// `Default value is null`
  final String? fileAssetId;

  final bool isExist;

  /// The original width
  final double originalWidth;

  /// The original height
  final double originalHeight;

  /// The use original size status
  ///
  /// This value is used to determine that should use the original size or not
  ///
  /// `Default value is false`
  final bool useOriginalSize;

  const MessageImageElementLocal({
    super.key,
    this.refFile,
    this.filePath,
    this.fileBytes,
    required this.imageWidth,
    required this.imageHeight,
    this.fileType = MessageFileType.image,
    this.blurhash,
    this.fileAssetId,
    this.isExist = true,
    this.originalWidth = 0,
    this.originalHeight = 0,
    this.useOriginalSize = false,
  });

  BlurHash get imageBlurHash {
    return BlurHash(
      key: ValueKey('file_blurhash_$refFile'),
      color: Colors.transparent,
      hash: blurhashDefault(blurhash),
      decodingWidth: imageWidth.toInt(),
      decodingHeight: imageHeight.toInt(),
      optimizationMode: BlurHashOptimizationMode.approximation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        final isCached = refFile != null ? GetIt.I<ThumbnailBytesCacheManager>().contains(refFile!) : false;

        final errorStateWidget = RepaintBoundary(
          child: Stack(
            children: [
              imageBlurHash,
              const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        );

        if (isExist == false) {
          return errorStateWidget;
        }

        if (fileBytes != null || fileAssetId != null || isCached) {
          final imageProvider = MessageLocalImageProvider(
            refFile: refFile!,
            fileType: fileType,
            bytes: fileBytes,
            assetId: fileAssetId,
            filePath: filePath,
          );
          final image = useOriginalSize
              ? imageProvider
              : ExtendedResizeImage.resizeIfNeeded(
                  provider: imageProvider,
                  cacheWidth: imageWidth.toInt(),
                  cacheHeight: imageHeight.toInt(),
                );
          final width = useOriginalSize ? originalWidth : imageWidth;
          final height = useOriginalSize ? originalHeight : imageHeight;
          final quality = useOriginalSize ? FilterQuality.high : FilterQuality.low;

          return ExtendedImage(
            key: ValueKey('message_local_image_provider-$refFile'),
            image: image,
            width: width,
            height: height,
            filterQuality: quality,
            fit: BoxFit.cover,
            loadStateChanged: (state) {
              final loadState = state.extendedImageLoadState;
              Widget imageChild = const SizedBox.shrink();
              if (loadState == LoadState.loading) {
                imageChild = imageBlurHash;
              }

              if (loadState == LoadState.failed) {
                imageChild = errorStateWidget;
              }

              if (loadState == LoadState.completed) {
                imageChild = SizedBox(
                  child: state.completedWidget,
                );
              }

              return AnimatedSwitcher(
                key: ValueKey('memory_image_element_local_switcher-$refFile'),
                duration: const Duration(milliseconds: 200),
                switchInCurve: Curves.easeIn,
                child: imageChild,
              );
            },
          );
        }

        if (filePath?.isNotEmpty == true) {
          return UChatImage.file(
            filePath!,
            fit: BoxFit.cover,
            width: imageWidth,
            height: imageHeight,
            customImageWidget: (state) {
              return ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                fit: BoxFit.cover,
              );
            },
            customLoadingWidget: (state) {
              return imageBlurHash;
            },
            customErrorWidget: (state) {
              return errorStateWidget;
            },
          );
        } else {
          return BlurHash(
            color: Colors.transparent,
            hash: blurhashDefault(blurhash),
            decodingWidth: imageWidth.toInt(),
            decodingHeight: imageHeight.toInt(),
            optimizationMode: BlurHashOptimizationMode.approximation,
          );
        }
      },
    );
  }
}
