import 'package:get/get.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_album_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_audio_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_file_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_image_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_sticker_gift_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_sticker_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_text_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_video_v2_controller.dart';

/// Base class for message binding operations
/// Contains common functionality for tag generation and message type controller management
abstract class BaseMessageBinding {
  /// Generates a container tag for message controllers
  /// Format: 'message_container_v2-{ref}'
  static String generateContainerTag(MessageCollection message, {String? suffix}) {
    final baseTag = 'message_container_v2-${message.ref}';
    return suffix != null ? '${baseTag}_$suffix' : baseTag;
  }

  /// Generates a message type tag for message type controllers
  /// Format: '{messageType}-{ref}' or '{messageType}-{ref}_{suffix}'
  static String generateMessageTypeTag(MessageCollection message, {String? suffix}) {
    if (message.type == null) {
      throw ArgumentError('Message type cannot be null when generating message type tag');
    }

    final baseTag = '${message.type!.value}-${message.ref}';
    return suffix != null ? '${baseTag}_$suffix' : baseTag;
  }

  /// Gets the message type tag for an existing message
  /// This is the standard tag used throughout the app
  static String getMessageTypeTag(MessageCollection message) {
    return generateMessageTypeTag(message);
  }

  /// Gets the message type tag with a specific suffix
  static String getMessageTypeTagWithSuffix(MessageCollection message, String suffix) {
    return generateMessageTypeTag(message, suffix: suffix);
  }

  /// Gets the container tag for an existing message
  static String getContainerTag(MessageCollection message) {
    return generateContainerTag(message);
  }

  /// Gets the container tag with a specific suffix
  static String getContainerTagWithSuffix(MessageCollection message, String suffix) {
    return generateContainerTag(message, suffix: suffix);
  }

  /// Put message type controllers based on message type
  /// This is the core logic shared between different binding implementations
  static void putMessageTypeControllers(
    MessageCollection message, {
    String? suffix,
    bool enableReact = true,
  }) {
    if (message.type == null) {
      return;
    }

    final messageTypeTag = generateMessageTypeTag(message, suffix: suffix);

    switch (message.type) {
      case MessageType.sticker:
        Get.put<MessageTypeStickerV2Controller>(
          MessageTypeStickerV2Controller(initMessage: message),
          tag: messageTypeTag,
          permanent: true,
        );
        break;
      case MessageType.stickerSharing:
        break;
      case MessageType.stickerGift:
        Get.put<MessageTypeStickerGiftV2Controller>(
          MessageTypeStickerGiftV2Controller(initMessage: message),
          tag: messageTypeTag,
          permanent: true,
        );
        break;
      case MessageType.gif:
        break;
      case MessageType.system:
        break;
      case MessageType.image:
        Get.put<MessageTypeImageV2Controller>(
          MessageTypeImageV2Controller(initMessage: message),
          tag: messageTypeTag,
          permanent: true,
        );
        break;
      case MessageType.file:
        Get.put<MessageTypeFileV2Controller>(
          MessageTypeFileV2Controller(initMessage: message),
          tag: messageTypeTag,
          permanent: true,
        );
        break;
      case MessageType.video:
        Get.put<MessageTypeVideoV2Controller>(
          MessageTypeVideoV2Controller(initMessage: message),
          tag: messageTypeTag,
          permanent: true,
        );
        break;
      case MessageType.audio:
        Get.put<MessageTypeAudioV2Controller>(
          MessageTypeAudioV2Controller(initMessage: message),
          tag: messageTypeTag,
          permanent: true,
        );
        break;
      case MessageType.remove:
        break;
      case MessageType.removeOthers:
        break;
      case MessageType.unsent:
        break;
      case MessageType.album:
        Get.put<MessageTypeAlbumV2Controller>(
          MessageTypeAlbumV2Controller(initMessage: message),
          tag: messageTypeTag,
          permanent: true,
        );
        break;
      case MessageType.location:
        break;
      case MessageType.callMsg:
        break;
      case MessageType.contact:
        break;
      case MessageType.mobileContact:
        break;
      default:
        Get.put<MessageTypeTextV2Controller>(
          MessageTypeTextV2Controller(
            initMessage: message,
            enableReact: enableReact,
          ),
          tag: messageTypeTag,
          permanent: true,
        );
        break;
    }
  }

  /// Close message type controllers based on message type
  /// This is the core logic shared between different binding implementations
  static void closeMessageTypeControllers(MessageCollection message, {String? suffix}) {
    if (message.type == null) {
      return;
    }

    final messageTypeTag = generateMessageTypeTag(message, suffix: suffix);

    switch (message.type) {
      case MessageType.sticker:
        Get.delete<MessageTypeStickerV2Controller>(tag: messageTypeTag, force: true);
        break;
      case MessageType.stickerSharing:
        break;
      case MessageType.stickerGift:
        Get.delete<MessageTypeStickerGiftV2Controller>(tag: messageTypeTag, force: true);
        break;
      case MessageType.gif:
        break;
      case MessageType.system:
        break;
      case MessageType.image:
        Get.delete<MessageTypeImageV2Controller>(tag: messageTypeTag, force: true);
        break;
      case MessageType.file:
        Get.delete<MessageTypeFileV2Controller>(tag: messageTypeTag, force: true);
        break;
      case MessageType.video:
        Get.delete<MessageTypeVideoV2Controller>(tag: messageTypeTag, force: true);
        break;
      case MessageType.audio:
        Get.delete<MessageTypeAudioV2Controller>(tag: messageTypeTag, force: true);
        break;
      case MessageType.remove:
        break;
      case MessageType.removeOthers:
        break;
      case MessageType.unsent:
        break;
      case MessageType.album:
        Get.delete<MessageTypeAlbumV2Controller>(tag: messageTypeTag, force: true);
        break;
      case MessageType.location:
        break;
      case MessageType.callMsg:
        break;
      case MessageType.contact:
        break;
      case MessageType.mobileContact:
        break;
      default:
        Get.delete<MessageTypeTextV2Controller>(tag: messageTypeTag, force: true);
        break;
    }
  }
}
