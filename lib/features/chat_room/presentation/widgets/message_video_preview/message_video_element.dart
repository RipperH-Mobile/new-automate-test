import 'dart:io';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_image_preview/message_image_element_local.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/blurhash.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/loading/chat_file_progress_indicator.dart';

class MessageVideoElement extends StatelessWidget {
  /// The tag for the hero animation
  ///
  /// This tag is used to identify the image for the hero animation
  final String messageFileTag;

  /// The message file model
  ///
  /// This model contains the information of the image file
  final MessageFileModel messageFile;

  /// The width of the image
  final double imageWidth;

  /// The height of the image
  final double imageHeight;

  /// The aspect ratio of the image
  ///
  /// This value is used to calculate the aspect ratio of the image
  ///
  /// `Default value is 1`
  final double aspectRatio;

  /// The on tap callback
  ///
  /// This callback is used to determine the action when the image is tapped
  ///
  /// `Default value is null`
  ///
  /// - If the value is null, the image will open the media viewer
  /// - If the value is not null, the image will call the callback (override the default action)
  final VoidCallback? onTap;

  /// The enable tap status
  ///
  /// This value is used to determine if the image is tappable or not
  final bool enableTap;

  /// The upload progress
  ///
  /// This value is used to determine the upload progress of the image
  final double uploadProgress;

  /// The show network image status
  ///
  /// This value is used to determine that should show the network image or not
  final bool shouldShowNetworkImage;

  /// The is sending status
  ///
  /// This value is used to determine the image is sending or not
  ///
  /// `Default value is false`
  final bool isSending;

  /// The is send failed status
  ///
  /// This value is used to determine the image is send failed or not
  ///
  /// `Default value is false`
  final bool isSendFailed;

  /// The on cancel upload callback
  ///
  /// This callback is used to determine the action when the upload is canceled
  ///
  /// `Default value is null`
  final void Function()? onCancelUpload;

  /// The is exist status
  ///
  /// This value is used to determine the image is exist or not
  final bool isExist;

  final String? heroTag;

  const MessageVideoElement({
    super.key,
    required this.messageFile,
    required this.messageFileTag,
    required this.imageWidth,
    required this.imageHeight,
    this.shouldShowNetworkImage = false,
    this.aspectRatio = 1,
    this.onTap,
    this.enableTap = true,
    this.uploadProgress = -1,
    this.onCancelUpload,
    this.isSending = false,
    this.isSendFailed = false,
    this.isExist = true,
    this.heroTag,
  });

  /// The enable tap compute status
  ///
  /// This value is used to determine if the image is tappable or not
  ///
  /// - If the image is sending, return false
  /// - If the image is show progress indicator, return false
  /// - If the image is enable tap, return true
  /// - Otherwise, return false
  bool get enableTapCompute {
    if (isSending) {
      return false;
    }

    return enableTap;
  }

  /// The show progress indicator status
  ///
  /// This value is used to determine if the progress indicator should be shown or not
  ///
  /// - If the message file is sending, return true
  /// - If the message file is send failed, return true
  bool get showProgressIndicator {
    return isSending;
  }

  /// The show duration status
  ///
  /// This value is used to determine if the duration should be shown or not
  ///
  /// - If the message file duration is null, return false
  /// - If the message file duration is greater than 0, return true
  /// - Otherwise, return false
  bool get showDuration {
    if (messageFile.duration == null) {
      return false;
    }

    return messageFile.duration! > 0;
  }

  /// Get the duration text
  ///
  /// This value is used to generate the duration text of the video
  ///
  /// - If the duration is greater than or equal to 60 minutes, return the duration in format `00:00:00 (hh:mm:ss)`
  /// - If the duration is less than 60 minutes, return the duration in format `00:00 (mm:ss)`
  String get durationText {
    final duration = Duration(
      milliseconds: messageFile.duration?.toInt() ?? 0,
    );

    if (duration.inMinutes >= 60) {
      // show in format 00:00:00 (hh:mm:ss)
      return duration.toString().split('.').first.padLeft(8, '0');
    } else {
      // show in format 00:00 (mm:ss)
      return duration.toString().split('.').first.substring(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enableTapCompute
          ? () {
              if (onTap != null) {
                onTap!();
              }
            }
          : null,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            /// Show the thumbnail image of the video
            Hero(
              tag: messageFileTag,
              transitionOnUserGestures: true,
              child: Align(
                alignment: Alignment.center,
                child: Builder(
                  builder: (_) {
                    if (!shouldShowNetworkImage) {
                      // Check if the message file is local or not,
                      // If the message file is local, return the local image element
                      return MessageImageElementLocal(
                        key: ValueKey('message_image_element_local-${messageFile.refFile}'),
                        refFile: messageFile.refFile,
                        blurhash: messageFile.blurhash,
                        filePath: messageFile.url,
                        fileBytes: messageFile.thumbnailBytes,
                        fileAssetId: messageFile.assetId,
                        fileType: messageFile.type ?? MessageFileType.video,
                        imageHeight: imageHeight,
                        imageWidth: imageWidth,
                        isExist: isExist,
                      );
                    }

                    // Image provider for the image
                    ImageProvider<Object>? imageProvider;

                    // Check if the message file has thumbnail file id or not,
                    // If the message file has thumbnail file id, get the image provider from the network
                    if (messageFile.thumbnailFileId != null) {
                      imageProvider = UChatImage.networkProvider(
                        FileService.instance.getFileUrl(messageFile.thumbnailFileId ?? ''),
                      );
                    }

                    // Check if the message file has thumbnail path or not,
                    // If the message file has thumbnail path, get the image provider from the file
                    if (messageFile.thumbnailPath != null) {
                      final tnFile = File(messageFile.thumbnailPath!);
                      if (tnFile.existsSync()) {
                        imageProvider = FileImage(File(messageFile.thumbnailPath!));
                      }
                    }

                    // Check if the message file has thumbnail bytes or not,
                    // If the message file has thumbnail bytes, get the image provider from the memory
                    if (messageFile.thumbnailBytes != null) {
                      imageProvider = MemoryImage(messageFile.thumbnailBytes!);
                    }

                    // Check if the image provider is null or not,
                    // If the image provider is null, return the blurhash
                    if (imageProvider == null) {
                      return Stack(
                        children: [
                          BlurHash(
                            hash: blurhashDefault(messageFile.blurhash),
                          ),
                          Center(
                            child: Icon(
                              Icons.error,
                              color: UTheme.color.accent,
                              size: 20.spMin,
                            ),
                          ),
                        ],
                      );
                    }

                    return ExtendedImage(
                      key: ValueKey('reply_${messageFile.refFile}'),
                      image: ExtendedResizeImage(
                        imageProvider,
                        width: imageWidth.toInt().cacheSize,
                        height: imageHeight.toInt().cacheSize,
                      ),
                      width: imageWidth,
                      height: imageHeight,
                      filterQuality: FilterQuality.low,
                      fit: BoxFit.cover,
                      loadStateChanged: (state) {
                        final loadState = state.extendedImageLoadState;

                        Widget imageChild = const SizedBox.shrink();
                        String keyWidget = '${messageFile.refFile}-image-state-${loadState.toString()}';

                        if (loadState == LoadState.loading) {
                          if (messageFile.blurhash != null) {
                            imageChild = BlurHash(
                              key: ValueKey(keyWidget),
                              hash: blurhashDefault(messageFile.blurhash),
                            );
                          } else {
                            imageChild = Center(
                              key: ValueKey(keyWidget),
                              child: const CircularProgressIndicator(),
                            );
                          }
                        }

                        if (loadState == LoadState.failed) {
                          imageChild = Center(
                            key: ValueKey(keyWidget),
                            child: const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          );
                        }

                        if (loadState == LoadState.completed) {
                          imageChild = SizedBox(
                            key: ValueKey(keyWidget),
                            child: state.completedWidget,
                          );
                        }

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 150),
                          switchInCurve: Curves.easeIn,
                          child: imageChild,
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            /// Show the progress indicator, play icon, or refresh icon
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 2000),
              switchInCurve: Curves.easeIn,
              child: Builder(
                builder: (_) {
                  // Check if the image is sending or not,
                  // If the image is sending, return the progress indicator
                  // If the image is not sending, return the play icon
                  // If the image is send failed, return the warning icon
                  if (showProgressIndicator) {
                    return Align(
                      alignment: Alignment.center,
                      child: Builder(
                        builder: (_) {
                          if (isSending == false) {
                            return const SizedBox.shrink();
                          }

                          // Check if the upload progress is greater than or equal to 100,
                          // If the upload progress is greater than or equal to 100, return the infinite loading progress indicator
                          if (messageFile.progressState == FileProgressState.uploaded ||
                              uploadProgress >= 100 ||
                              uploadProgress < 0) {
                            final shouldShowStopIcon = uploadProgress < 100;
                            return ChatFileProgressIndicator(
                              isInfiniteLoading: true,
                              showStopIcon: shouldShowStopIcon,
                              indicatorRadius: 24.spMin,
                              outerLineWidth: 5,
                              onTap: shouldShowStopIcon
                                  ? () {
                                      onCancelUpload?.call();
                                    }
                                  : null,
                            );
                          }

                          // Check if the upload progress is less than 100,
                          // If the upload progress is less than 100, return the progress indicator
                          return ChatFileProgressIndicator(
                            onTap: () {
                              onCancelUpload?.call();
                            },
                            progress: uploadProgress / 100,
                            indicatorRadius: 24.spMin,
                            showStopIcon: showProgressIndicator,
                          );
                        },
                      ),
                    );
                  } else {
                    Widget child = const SizedBox.shrink();

                    if (isSending) {
                      // Check if the image is sending or not,
                      // If the image is sending, return the progress indicator
                      return child;
                    }

                    // Check if the image is not sending and not send failed,
                    // If the image is not sending and not send failed, return the play icon
                    child = Center(
                      child: isSendFailed ? Assets.vectors.warningSymbol.svg() : Assets.vectors.play.svg(),
                    );

                    return ClipOval(
                      child: RepaintBoundary(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                          child: Container(
                            height: 48.spMin,
                            width: 48.spMin,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFF0E1216).withValues(alpha: .8),
                                  const Color(0xFF333942).withValues(alpha: .8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(AppRadius.roundedFull),
                            ),
                            child: Center(child: child),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),

            /// Show the duration of the video
            if (showDuration)
              Positioned(
                right: AppSpace.space3,
                bottom: AppSpace.space3,
                child: RepaintBoundary(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpace.space2,
                          vertical: AppSpace.space1,
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
                        child: AppText.body4(
                          durationText,
                          context: context,
                          color: context.theme.appColors.textPrimaryInverse,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
