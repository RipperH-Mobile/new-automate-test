import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/file_download_status.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_file_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/loading/chat_file_progress_indicator.dart';

class MessageTypeFileV2 extends GetView<MessageTypeFileV2Controller> {
  final String messageTag;
  final Widget? status;

  const MessageTypeFileV2({
    super.key,
    required this.messageTag,
    this.status,
  });

  @override
  String get tag => messageTag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: ValueKey(tag),
      builder: (context, c) {
        return ContextMenuWidget(
          forceAlignment: _getAlignment(),
          width: c.maxWidth,
          longPressCallback: _handleLongPress,
          actions: controller.actions(controller.message.value),
          topWidgetHeight: controller.canReact ? MessageReactionPopup.height : null,
          topWidget: controller.canReact
              ? MessageReactionPopup(
                  messageTag: tag,
                )
              : null,
          child: GestureDetector(
            onTap: controller.handleOpenFile,
            child: _buildMessageContainer(context),
          ),
        );
      },
    );
  }

  Alignment _getAlignment() {
    return controller.message.value?.mine == true ? Alignment.centerLeft : Alignment.centerRight;
  }

  void _handleLongPress() {
    String mediaType = 'file';
    GetIt.I<TaxonomyService>().sendEvent(
      EventName.longpressChatroom,
      eventProperties: EventProperty.longPressChatRoom(mediaType),
    );
  }

  Widget _buildMessageContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.space3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        color: _getMessageBackgroundColor(context),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildThumbnailSection(context),
          AppSpace.space3.horizontalSpace,
          _buildNameAndSizeSection(context),
        ],
      ),
    );
  }

  Color _getMessageBackgroundColor(BuildContext context) {
    return controller.message.value?.mine == true
        ? context.theme.appColors.backgroundPrimary
        : context.theme.appColors.backgroundNeutralLight;
  }

  Widget _buildThumbnailSection(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.roundedLg)),
      child: SizedBox(
        height: AppSize.size16,
        width: AppSize.size16,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            FittedBox(
              fit: BoxFit.cover,
              child: Obx(() {
                final file = controller.message.value?.file;

                /// Show default icon when file is null
                if (file == null) {
                  return Assets.vectors.fileCoverDefault.svg();
                }

                if (file.isPasswordProtected == true) {
                  return Assets.vectors.lockedFileCover.svg();
                }

                /// Show local thumbnail when sending file message with local thumbnail bytes
                if (file.thumbnailBytes != null && file.thumbnailBytes!.isNotEmpty) {
                  return RepaintBoundary(
                    child: ColoredBox(
                      color: Colors.white,
                      child: Image.memory(
                        file.thumbnailBytes!,
                        fit: BoxFit.cover,
                        height: AppSize.size16,
                        width: AppSize.size16,
                        cacheWidth: AppSize.size16.cacheSize,
                      ),
                    ),
                  );
                }

                return _buildThumbnailBackground(context);
              }),
            ),
            _buildThumbnailOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnailBackground(BuildContext context) {
    return Obx(() {
      if (controller.isLockedFile.value) {
        return Assets.vectors.lockedFileCover.svg();
      } else if (controller.thumbnailFileId.value.isNotEmpty) {
        return UChatImage.network(
          FileService.instance.getFileUrl(controller.thumbnailFileId.value),
          fit: BoxFit.cover,
          height: AppSize.size16,
          width: AppSize.size16,
          customLoadingWidget: (state) => _buildLoadingIndicator(context),
          customImageWidget: (state) {
            return ColoredBox(color: Colors.white, child: state.completedWidget);
          },
        );
      } else {
        return Assets.vectors.fileCoverDefault.svg();
      }
    });
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Container(
      color: context.theme.appColors.backgroundNeutralLight.withValues(alpha: 0.5),
      child: CupertinoActivityIndicator(
        radius: AppSize.size3,
        color: context.theme.appColors.backgroundNeutralLightPressed,
      ),
    );
  }

  Widget _buildThumbnailOverlay(BuildContext context) {
    return Obx(() {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _getOverlayColor(),
          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.roundedLg)),
        ),
        child: _buildProgressIndicator(context),
      );
    });
  }

  Color _getOverlayColor() {
    return controller.message.value?.isSent != true ||
            (controller.downloadProgress.value > 0 && controller.downloadProgress.value < 1)
        ? Colors.black.withValues(alpha: 0.2)
        : Colors.transparent;
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Obx(() {
      if (controller.uploadProgressTotal.value > 0) {
        final progress = controller.uploadProgressSend.value / controller.uploadProgressTotal.value;
        if (progress >= 0.0 && progress < 1.0) {
          return ChatFileProgressIndicator(
            progress: progress,
            indicatorRadius: 21.spMin,
            outerLineWidth: 5.spMin,
            showStopIcon: true,
            stopIcon: Assets.vectors.xClose.svg(
              height: AppSize.size3,
              width: AppSize.size3,
              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            backgroundColor: Colors.transparent,
            onTap: controller.cancelUpload,
          );
        }

        if (controller.message.value?.isSent != true) {
          return const CupertinoActivityIndicator(
            color: Colors.white,
          );
        }
      }

      final List<FileDownloadStatus> downloadingStatuses = [
        FileDownloadStatus.loading,
        FileDownloadStatus.waitingToStart,
        FileDownloadStatus.waitingToRetry,
      ];
      if (downloadingStatuses.contains(controller.message.value?.file?.downloadStatus)) {
        final progress = controller.downloadProgress.value;
        final showInfiniteLoading = progress <= 0.0 || progress >= 1.0;
        return ChatFileProgressIndicator(
          progress: progress,
          isInfiniteLoading: showInfiniteLoading,
          indicatorRadius: 21.spMin,
          outerLineWidth: 5.spMin,
          showStopIcon: true,
          stopIcon: Assets.vectors.xClose.svg(
            height: AppSize.size3,
            width: AppSize.size3,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          backgroundColor: Colors.transparent,
          onTap: progress < 1.0 ? controller.cancelDownload : null,
        );
      }

      return const SizedBox.shrink();
    });
  }

  Widget _buildNameAndSizeSection(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFileNameRow(context),
          AppSpace.space1.verticalSpace,
          _buildFileSizeText(context),
        ],
      ),
    );
  }

  Widget _buildFileNameRow(BuildContext context) {
    return Flexible(
      child: AppText.body2(
        controller.getFileName(),
        color: _getTextColor(context),
        maxLines: 1,
        textOverflow: TextOverflow.ellipsis,
        context: context,
      ),
    );
  }

  Widget _buildFileSizeText(BuildContext context) {
    return Obx(() {
      if (controller.downloadProgress.value > 0 && controller.downloadProgress.value < 1) {
        return AppText.body4(
          _getDownloadProgressDescription(),
          color: _getTextColor(context),
          context: context,
        );
      }
      final file = controller.message.value?.file;
      final fileSize = file?.size;
      String size =
          fileSize != null ? controller.getFileExtensionFileSizeDescription(file) : _getUploadProgressDescription();

      return AppText.body4(
        size,
        color: _getTextColor(context),
        context: context,
      );
    });
  }

  String _getUploadProgressDescription() {
    final sent = controller.uploadProgressSend.toInt();
    final total = controller.uploadProgressTotal.toInt();
    final sentDescription = controller.getFileSizeDescription(sent);
    final totalDescription = controller.getFileSizeDescription(total);

    return (sent / total >= 1) ? 'Finishing soon...'.tr : '$sentDescription/$totalDescription';
  }

  String _getDownloadProgressDescription() {
    final total = controller.uploadProgressTotal.toInt();
    final downloadedDescription =
        controller.getFileSizeDescription((controller.downloadProgress.value * total).toInt());
    final totalDescription = controller.getFileSizeDescription(total);

    return '$downloadedDescription/$totalDescription';
  }

  Color _getTextColor(BuildContext context) {
    return controller.message.value?.mine == true
        ? context.theme.appColors.textPrimaryInverse
        : context.theme.appColors.textDarkest;
  }

  Widget buildReplyFile(BuildContext context, MessageCollection message) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.space3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        color: message.mine == true
            ? context.theme.appColors.backgroundPrimary
            : context.theme.appColors.backgroundNeutralLight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// [Thumbnail] section
          //Show loading indicator when message is on uploading state
          Stack(
            alignment: Alignment.center,
            children: [
              message.file?.isPasswordProtected ?? false
                  ? Assets.vectors.lockedFileCover.svg()
                  : message.file?.thumbnailFileId != null
                      ? ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(AppRadius.roundedLg)),
                          child: UChatImage.network(
                            FileService.instance.getFileUrl(message.file!.thumbnailFileId!),
                            fit: BoxFit.cover,
                            height: AppSize.size16,
                            width: AppSize.size16,
                            customLoadingWidget: (state) {
                              return Container(
                                color: context.theme.appColors.backgroundNeutralLight.withValues(alpha: 0.5),
                                child: CupertinoActivityIndicator(
                                  radius: AppSize.size3,
                                  color: context.theme.appColors.backgroundNeutralLightPressed,
                                ),
                              );
                            },
                          ),
                        )
                      : Assets.vectors.fileCoverDefault.svg(),
            ],
          ),
          AppSpace.space3.horizontalSpace,

          /// [Name & Size] section
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /// File [Name] section
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AppText.body2(
                        message.file?.name?.split('.')[0] ?? 'UNKNOWN',
                        color: message.mine == true
                            ? context.theme.appColors.textPrimaryInverse
                            : context.theme.appColors.textDarkest,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        context: context,
                      ),
                    ),
                    AppText.body2(
                      '.${message.file?.fileExt ?? 'UNKNOWN'}',
                      color: message.mine == true
                          ? context.theme.appColors.textPrimaryInverse
                          : context.theme.appColors.textDarkest,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                      context: context,
                    ),
                  ],
                ),
                AppSpace.space1.verticalSpace,

                /// File [Size] section
                AppText.body4(
                  FileService.instance.fileSizeStr(message.file?.size ?? 0, 0),
                  color: message.mine == true
                      ? context.theme.appColors.textPrimaryInverse
                      : context.theme.appColors.textDarkest,
                  context: context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
