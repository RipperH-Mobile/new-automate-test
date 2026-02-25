import 'package:animate_do/animate_do.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_image_preview/message_image_element_local.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/blurhash.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/checkbox/round_checkbox.dart';
import 'package:uchat/widgets/loading/chat_file_progress_indicator.dart';

import 'message_image_asset_entity_preview.dart';

class MessageImageElement extends StatelessWidget {
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

  /// The selection status of the image
  ///
  /// This value is used to determine if the image is selected or not
  ///
  /// `Default value is false`
  final bool openSelection;
  final bool isImageSelected;

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

  final double imageCompressProgress;

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

  /// The on cancel upload callback
  ///
  /// This callback is used to determine the action when the upload is canceled
  ///
  /// `Default value is null`
  final void Function(String? refFile)? onCancelUpload;

  /// The is exist status
  ///
  /// This value is used to determine the image is exist or not
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

  const MessageImageElement({
    super.key,
    required this.messageFile,
    required this.messageFileTag,
    required this.imageWidth,
    required this.imageHeight,
    this.shouldShowNetworkImage = false,
    this.aspectRatio = 1,
    this.openSelection = false,
    this.isImageSelected = false,
    this.onTap,
    this.enableTap = true,
    this.uploadProgress = 0,
    this.isSending = false,
    this.onCancelUpload,
    this.isExist = true,
    this.originalWidth = 0,
    this.originalHeight = 0,
    this.useOriginalSize = false,
    this.imageCompressProgress = 0,
  });

  bool get enableTapCompute {
    if (messageFile.isLocked == true) {
      return false;
    }

    return enableTap;
  }

  @override
  Widget build(BuildContext context) {
    final checkBoxSize = AppSpace.space8;

    return GestureDetector(
      onTap: enableTapCompute
          ? () {
              onTap?.call();
            }
          : null,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            /// Image
            _buildImage(),

            _buildProgressIndicator(
              context,
            ),

            /// Selection checkbox
            if (openSelection)
              _buildSelectionCheckBox(
                context,
                checkBoxSize,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: messageFileTag,
      transitionOnUserGestures: true,
      child: Align(
        alignment: Alignment.center,
        child: Builder(
          builder: (_) {
            if (messageFile.isLocked == true) {
              return const Text('Locked Message');
            }

            if (messageFile.assetId?.isNotEmpty == true) {
              return ImageAssetEntityPreview(
                height: imageHeight,
                width: imageWidth,
                messageFileModel: messageFile,
                fallBackWidget: messageFile.apiFileUrl != null
                    ? _getImage(messageFile.apiFileUrl!, useOriginalSize, imageWidth, imageHeight)
                    : null,
              );
            }

            if (messageFile.apiFileUrl?.isNotEmpty == true) {
              return _getImage(messageFile.apiFileUrl!, useOriginalSize, imageWidth, imageHeight);
            }
            return MessageImageElementLocal(
              key: ValueKey('message_image_element_local-${messageFile.refFile}'),
              refFile: messageFile.refFile,
              blurhash: blurhashDefault(messageFile.blurhash),
              filePath: messageFile.url,
              fileAssetId: messageFile.assetId,
              fileType: messageFile.type ?? MessageFileType.image,
              imageHeight: imageHeight,
              imageWidth: imageWidth,
              originalWidth: originalWidth,
              originalHeight: originalHeight,
              useOriginalSize: useOriginalSize,
              isExist: isExist,
            );
          },
        ),
      ),
    );
  }

  Widget _getImage(String url, bool useOriginalSize, double width, double height) {
    return UChatImage.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      cache: true,
      maxBytes: UChatConstant.maxImageCacheSize,
      cacheMaxAge: const Duration(days: 15),
      customLoadingWidget: (state) => _buildLoadState(state),
    );
  }

  Widget _buildLoadState(ExtendedImageState state) {
    final loadState = state.extendedImageLoadState;
    final keyWidget = '${messageFile.refFile}-image-state-${loadState.toString()}';
    switch (loadState) {
      case LoadState.loading:
        return messageFile.blurhash != null
            ? BlurHash(
                key: ValueKey(keyWidget),
                hash: blurhashDefault(messageFile.blurhash),
                optimizationMode: BlurHashOptimizationMode.approximation,
              )
            : Center(key: ValueKey(keyWidget), child: const CircularProgressIndicator());
      case LoadState.failed:
        return Center(
          key: ValueKey(keyWidget),
          child: const Icon(Icons.error, color: Colors.red),
        );
      case LoadState.completed:
        return SizedBox(key: ValueKey(keyWidget), child: state.completedWidget);
    }
  }

  Widget _buildProgressIndicator(BuildContext context) {
    final progress = uploadProgress;
    final isNegativeProgress = progress < 0 || uploadProgress < 0 || imageCompressProgress < 0 || (!isSending);
    final isInProgress = [FileProgressState.uploading, FileProgressState.idle].contains(messageFile.progressState);
    if (isNegativeProgress) {
      return const SizedBox.shrink();
    }
    return Container(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: ChatFileProgressIndicator(
          progress: progress,
          showStopIcon: isInProgress && onCancelUpload != null,
          sizeBox: 48.spMin,
          indicatorRadius: 24.spMin,
          onTap: messageFile.progressState == FileProgressState.uploaded || progress >= 1
              ? null
              : () => onCancelUpload?.call(messageFile.refFile),
        ),
      ),
    );
  }

  Widget _buildSelectionCheckBox(BuildContext context, double checkBoxSize) {
    return Positioned(
      top: 10,
      right: 10,
      child: AnimatedSwitcher(
        duration: UChatConstant.messageSelectionAnimateDuration,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: SizedBox(
          width: checkBoxSize,
          height: checkBoxSize,
          child: Padding(
            padding: const EdgeInsets.all(AppSpace.space05),
            child: IgnorePointer(
              // Using parent gesture instead, so ignore check box gesture.
              child: UChatRoundCheckBox(
                animationDuration: Duration.zero,
                checkedWidget: Padding(
                  padding: const EdgeInsets.all(AppSpace.space1),
                  child: ZoomIn(
                    from: 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Assets.vectors.check12.svg(
                      colorFilter: ColorFilter.mode(
                        context.theme.appColors.iconPrimaryInverse,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                isChecked: isImageSelected,
                borderColor: context.theme.appColors.borderLight,
                uncheckedColor: context.theme.appColors.backgroundGray.withValues(alpha: .32),
                checkedColor: context.theme.appColors.backgroundPrimary,
                onTap: (_) {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
