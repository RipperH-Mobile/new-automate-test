import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_image_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_image_preview/message_image_element.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';

typedef OnImageItemSelected = void Function(MessageCollection, MessageFileModel);

class MessageTypeImageV2 extends GetView<MessageTypeImageV2Controller> {
  /// The message collection
  final MessageCollection message;

  /// The message tag for the controller
  final String messageTag;

  /// The open selection
  ///
  /// This value is used to determine the open selection
  ///
  /// `Default value is false`
  final List<MessageCollection>? selectedMsg;
  final OnImageItemSelected? onImageItemSelected;
  final bool isAllowSelection;

  /// The on tap callback
  ///
  /// This callback is used to determine the action when the image is tapped
  ///
  /// `Default value is null`
  ///
  /// - If the value is null, the image will open the media viewer
  /// - If the value is not null, the image will call the callback (override the default action)
  final VoidCallback? onTap;

  const MessageTypeImageV2({
    super.key,
    required this.message,
    required this.messageTag,
    this.selectedMsg,
    this.onTap,
    this.onImageItemSelected,
    this.isAllowSelection = false,
  });

  @override
  String get tag => messageTag;

  bool get selectImageActive => selectedMsg != null;

  bool get isSelectionMsgFull => (selectedMsg?.length ?? 0) >= UChatConstant.maxSelectedMessage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        return buildImage(context, c, false);
      },
    );
  }

  Widget buildImage(BuildContext context, BoxConstraints c, bool isReply) {
    return Obx(() {
      if (controller.fileLength == 0) {
        return const SizedBox.shrink();
      }

      final parentMsgSelected = selectedMsg?.where((e) => e.ref == message.ref);
      final isSingleImage = controller.fileLength == 1;

      Widget child =
          isSingleImage ? _buildSingleImage(parentMsgSelected, isReply) : _buildImageGrid(parentMsgSelected, isReply);

      return isReply ? _buildReplyContainer(context, child) : _buildContextMenu(context, child, c, isReply);
    });
  }

  Widget _buildSingleImage(Iterable<MessageCollection>? parentMsgSelected, bool isReply) {
    final messageFile = controller.messageFiles.first;
    final (imageWidth, imageHeight) = controller.computeImageDimension(
      originWidth: messageFile.width ?? 0,
      originHeight: messageFile.height ?? 0,
    );
    final aspectRatio = imageWidth > 0 && imageHeight > 0 ? imageWidth / imageHeight : 1.0;
    final heroTag =
        isReply ? ('${messageFile.heroTag ?? messageFile.url}-reply') : (messageFile.heroTag ?? messageFile.url ?? '');

    return MessageImageElement(
      messageFile: messageFile,
      messageFileTag: heroTag,
      imageWidth: imageWidth,
      imageHeight: imageHeight,
      originalWidth: messageFile.width?.toDouble() ?? imageWidth,
      originalHeight: messageFile.height?.toDouble() ?? imageHeight,
      useOriginalSize: true,
      aspectRatio: aspectRatio,
      openSelection: false,
      isImageSelected: parentMsgSelected?.any((e) => e.files?.firstOrNull?.id == messageFile.id) ?? false,
      onTap: selectImageActive
          ? () => onImageItemSelected?.call(message, messageFile)
          : onTap ?? () => controller.onOpenMediaViewer(targetMessage: message),
      shouldShowNetworkImage: controller.shouldShowNetworkImage.value,
      uploadProgress: messageFile.downloadProgress,
      imageCompressProgress: messageFile.compressProgress,
      isSending: controller.initMessage.isSending ?? false,
      isExist: controller.isFileExist(messageFile.refFile),
      enableTap: !isReply,
      onCancelUpload: controller.onCancelUpload,
    );
  }

  Widget _buildImageGrid(Iterable<MessageCollection>? parentMsgSelected, bool isReply) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpace.spacePx,
      children: List.generate(controller.numberOfRow, (rowIndex) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpace.spacePx,
          children: List.generate(controller.numberOfColumn(rowIndex), (columnIndex) {
            final messageFileIndex = controller.getFile(rowIndex, columnIndex);
            final messageFile = controller.messageFiles.elementAtOrNull(messageFileIndex);
            if (messageFile == null) {
              return const SizedBox.shrink();
            }
            final (imageWidth, imageHeight) = controller.computeImageDimension(
              originWidth: messageFile.width ?? 0,
              originHeight: messageFile.height ?? 0,
            );
            final isLastRow = rowIndex == controller.numberOfRow - 1;
            final customImageWidth = isLastRow && controller.isOddFileLength
                ? controller.maxWidth
                : imageWidth.clamp(controller.maxWidth / 2, double.infinity);
            final customImageHeight = isLastRow && controller.isOddFileLength
                ? controller.maxWidth
                : imageHeight.clamp(controller.maxWidth / 2, double.infinity);

            return Expanded(
              child: Opacity(
                opacity: _getImageOpacity(parentMsgSelected, messageFile),
                child: MessageImageElement(
                  messageFileTag: messageFile.heroTag ?? messageFile.url ?? '',
                  messageFile: messageFile,
                  imageWidth: customImageWidth,
                  imageHeight: customImageHeight,
                  originalWidth: messageFile.width?.toDouble() ?? customImageWidth,
                  originalHeight: messageFile.height?.toDouble() ?? customImageHeight,
                  useOriginalSize: true,
                  aspectRatio: controller.aspectRatio(rowIndex),
                  openSelection: selectImageActive && isAllowSelection,
                  isImageSelected:
                      parentMsgSelected?.any((e) => e.files?.firstOrNull?.refFile == messageFile.refFile) ?? false,
                  onTap: _getImageTapAction(parentMsgSelected, messageFile),
                  shouldShowNetworkImage: controller.shouldShowNetworkImage.value,
                  uploadProgress: messageFile.downloadProgress,
                  imageCompressProgress: messageFile.compressProgress,
                  isExist: controller.isFileExist(messageFile.refFile),
                  enableTap: !isReply,
                  isSending: controller.initMessage.isSending ?? false,
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildReplyContainer(BuildContext context, Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
      child: Container(
        color: context.theme.appColors.backgroundGrayLighter,
        constraints: BoxConstraints(
          maxHeight: controller.maxHeight,
          maxWidth: 280.spMin,
          minHeight: controller.minHeight,
          minWidth: controller.minWidth,
        ),
        child: child,
      ),
    );
  }

  Widget _buildContextMenu(BuildContext context, Widget child, BoxConstraints c, bool isReply) {
    return ContextMenuWidget(
      childBoxConstraints: BoxConstraints(
        maxHeight: controller.maxHeight,
        maxWidth: controller.maxWidth,
        minHeight: controller.minHeight,
        minWidth: controller.minWidth,
      ),
      forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
      width: c.maxWidth,
      longPressCallback: () {
        GetIt.I<TaxonomyService>().sendEvent(
          EventName.longpressChatroom,
          eventProperties: EventProperty.longPressChatRoom(
            EventProperty.getMessageTypeForEventParams(message.type!),
          ),
        );
      },
      actions: controller.initMessage.isSending == false ? controller.actions(message) : [],
      topWidgetHeight: controller.canReact ? MessageReactionPopup.height : null,
      topWidget: controller.canReact
          ? MessageReactionPopup(
              messageTag: tag,
            )
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
        child: Container(
          color: context.theme.appColors.backgroundGrayLighter,
          constraints: BoxConstraints(
            maxHeight: controller.maxHeight,
            maxWidth: controller.maxWidth,
            minHeight: controller.minHeight,
            minWidth: controller.minWidth,
          ),
          child: child,
        ),
      ),
    );
  }

  double _getImageOpacity(Iterable<MessageCollection>? parentMsgSelected, MessageFileModel messageFile) {
    final isChecked = parentMsgSelected?.any((e) => e.files?.firstOrNull?.refFile == messageFile.refFile) ?? false;
    return isChecked || !isSelectionMsgFull ? 1.0 : 0.5;
  }

  VoidCallback? _getImageTapAction(Iterable<MessageCollection>? parentMsgSelected, MessageFileModel messageFile) {
    final isChecked = parentMsgSelected?.any((e) => e.files?.firstOrNull?.refFile == messageFile.refFile) ?? false;
    return selectImageActive
        ? (isSelectionMsgFull && !isChecked ? null : () => onImageItemSelected?.call(message, messageFile))
        : onTap ??
            () => controller.onOpenMediaViewer(
                  targetMessage: message,
                  index: message.files?.indexWhere((element) => element.id == messageFile.id) ?? 0,
                );
  }
}
