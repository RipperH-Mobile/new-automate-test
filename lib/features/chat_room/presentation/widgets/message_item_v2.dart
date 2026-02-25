import 'package:flutter/material.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/bindings/message_binding.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_album_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_audio_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_call_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_file_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_image_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_mobile_contact_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_contact_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_gif_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_location_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_remove_others.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_sticker_gift_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_sticker_sharing_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_sticker_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_system_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_v2.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_video_v2.dart';

class MessageItemV2 extends StatelessWidget {
  final MessageCollection message;
  final bool isMyMessage;
  final MessageType? messageType;
  final Widget? status;
  final List<MessageCollection>? selectedMsg;
  final OnImageItemSelected? onImageItemSelected;
  final bool isAllowSelection;
  final String? messageTag;

  const MessageItemV2({
    super.key,
    required this.message,
    this.isMyMessage = false,
    this.messageType,
    this.status,
    this.selectedMsg,
    this.onImageItemSelected,
    this.isAllowSelection = false,
    this.messageTag,
  });

  @override
  Widget build(BuildContext context) {
    if (messageType == null) return const SizedBox.shrink();

    final tag = messageTag ?? MessageBinding.getMessageTypeTag(message);

    switch (messageType) {
      case MessageType.sticker:
        return MessageTypeStickerV2(
          message: message,
          messageTag: tag,
        );
      case MessageType.stickerSharing:
        return MessageTypeStickerSharingV2(
          message: message,
          messageTag: tag,
        );
      case MessageType.stickerGift:
        return MessageTypeStickerGiftV2(
          message: message,
          messageTag: tag,
        );
      case MessageType.gif:
        return MessageTypeGifV2(
          message: message,
          messageTag: tag,
          gifId: message.meta?.giphyId,
          gifUrl: message.meta?.gifUrl,
          width: message.meta?.gifWidth,
          height: message.meta?.gifHeight,
        );
      case MessageType.system:
        return MessageTypeSystemV2(
          message: message,
        );
      case MessageType.image:
        return MessageTypeImageV2(
          message: message,
          messageTag: tag,
          selectedMsg: selectedMsg,
          onImageItemSelected: onImageItemSelected,
          isAllowSelection: isAllowSelection,
        );
      case MessageType.file:
        return MessageTypeFileV2(
          messageTag: tag,
          status: status,
        );
      case MessageType.video:
        return MessageTypeVideoV2(
          message: message,
          messageTag: tag,
        );
      case MessageType.audio:
        return MessageTypeAudioV2(
          message: message,
          messageTag: tag,
        );
      case MessageType.remove:
        return Container();
      case MessageType.removeOthers:
        return MessageTypeRemoveOthers(
          message: message,
        );
      case MessageType.unsent:
        return Container();
      case MessageType.album:
        return MessageTypeAlbumV2(
          message: message,
          messageTag: tag,
        );
      case MessageType.location:
        return MessageTypeLocationV2(
          message: message,
          messageTag: tag,
        );
      case MessageType.callMsg:
        return MessageTypeCallV2(
          message: message,
        );
      case MessageType.contact:
        return MessageTypeContactV2(
          message: message,
          messageTag: tag,
        );
      case MessageType.mobileContact:
        return MessageTypeMobileContactV2(
          message: message,
          messageTag: tag,
        );
      default:
        return MessageTypeTextV2(
          messageTag: tag,
          status: status,
        );
    }
  }
}
