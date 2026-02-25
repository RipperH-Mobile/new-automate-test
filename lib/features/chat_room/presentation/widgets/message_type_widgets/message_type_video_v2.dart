import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_video_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_video_preview/message_video_element.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';

class MessageTypeVideoV2 extends GetView<MessageTypeVideoV2Controller> {
  final MessageCollection message;
  final String messageTag;

  final VoidCallback? onTap;

  const MessageTypeVideoV2({super.key, required this.message, required this.messageTag, this.onTap});

  @override
  String get tag => messageTag;

  /// The maximum height for the image box
  double get maxHeight {
    // This is the maximum height for single image
    // Change this value to adjust the maximum height for single image box
    return 400.spMin;
  }

  /// The maximum width for the image box
  double get maxWidth => 350.spMin;

  /// The minimum width for the image box
  double get minWidth => 50.spMin;

  /// The minimum height for the image box
  double get minHeight => 50.spMin;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return Obx(() {
        double imageWidth = controller.imageWidth;
        double imageHeight = controller.imageHeight;
        (imageWidth, imageHeight) = computeImageDimension(originWidth: imageWidth, originHeight: imageHeight);

        return ContextMenuWidget(
          childBoxConstraints: BoxConstraints(
            maxHeight: imageHeight,
            maxWidth: imageWidth,
            minHeight: minHeight,
            minWidth: minWidth,
          ),
          forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
          width: c.maxWidth,
          longPressCallback: () {
            String mediaType = 'VDO';
            if (message.type != null) {
              mediaType = EventProperty.getMessageTypeForEventParams(message.type!);
            }
            GetIt.I<TaxonomyService>()
                .sendEvent(EventName.longpressChatroom, eventProperties: EventProperty.longPressChatRoom(mediaType));
          },
          actions: controller.actions(message),
          topWidgetHeight: controller.canReact ? MessageReactionPopup.height : null,
          topWidget: controller.canReact
              ? MessageReactionPopup(
                  messageTag: tag,
                )
              : null,
          child: buildVideo(
            context,
            isReply: false,
          ),
        );
      });
    });
  }

  Widget buildVideo(BuildContext context, {bool isCanClick = true, bool isReply = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      child: Container(
        color: context.theme.appColors.backgroundGrayLighter,
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          maxWidth: maxWidth,
          minHeight: minHeight,
          minWidth: minWidth,
        ),
        child: Builder(builder: (_) {
          Widget child = const SizedBox.shrink();

          final messageFile = controller.messageFile;
          if (messageFile == null) {
            return child;
          }

          return Obx(() {
            double imageWidth = controller.imageWidth;
            double imageHeight = controller.imageHeight;
            (imageWidth, imageHeight) = computeImageDimension(originWidth: imageWidth, originHeight: imageHeight);
            final aspectRatio = imageWidth > 0 && imageHeight > 0 ? imageWidth / imageHeight : 1.0;

            if (imageWidth.isNaN || imageWidth.isInfinite) {
              imageWidth = maxWidth;
            }

            if (imageHeight.isNaN || imageHeight.isInfinite) {
              imageHeight = maxHeight;
            }

            final uploadProgress = controller.getUploadProgress();
            String heroTag = isReply
                ? ('${messageFile.heroTag ?? messageFile.url}-reply')
                : (messageFile.heroTag ?? messageFile.url ?? '');

            return MessageVideoElement(
              messageFileTag: heroTag,
              messageFile: messageFile,
              imageWidth: imageWidth,
              imageHeight: imageHeight,
              aspectRatio: aspectRatio,
              onTap: isCanClick ? onTap ?? () => controller.onOpenMediaViewer(context) : null,
              uploadProgress: uploadProgress,
              isSending: controller.isSending,
              isSendFailed: controller.isSentFailed,
              onCancelUpload: controller.cancelUploadVideo,
              shouldShowNetworkImage: controller.shouldShowNetworkThumbnail.value,
              isExist: controller.isFileExist.value,
              enableTap: isCanClick ? true : false,
            );
          });
        }),
      ),
    );
  }

  (double, double) computeImageDimension({required double originWidth, required double originHeight}) {
    double imageWidth = originWidth;
    double imageHeight = originHeight;

    /// Handle Landscape Image
    if (imageHeight < imageWidth) {
      if (imageWidth > maxWidth) {
        imageWidth = maxWidth;
        imageHeight = imageWidth * originHeight / originWidth;
      }

      if (imageWidth < maxWidth) {
        imageWidth = maxWidth;
        imageHeight = imageWidth * originHeight / originWidth;
      }

      if (imageHeight < minHeight) {
        imageHeight = minHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      return (imageWidth, imageHeight);
    }

    /// Handle Portrait Image
    if (imageHeight > imageWidth) {
      if (imageHeight > maxHeight) {
        imageHeight = maxHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      if (imageHeight < maxHeight) {
        imageHeight = maxHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      if (imageWidth < minWidth) {
        imageWidth = minWidth;
        imageHeight = imageWidth * originHeight / originWidth;
      }

      return (imageWidth, imageHeight);
    }

    /// Handle Square Image
    if (imageHeight == imageWidth) {
      if (imageHeight > maxHeight) {
        imageHeight = maxHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      if (imageHeight < minHeight) {
        imageHeight = minHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      if (imageHeight < maxHeight) {
        imageHeight = maxHeight;
        imageWidth = imageHeight * originWidth / originHeight;
      }

      return (imageWidth, imageHeight);
    }

    return (imageWidth, imageHeight);
  }
}
