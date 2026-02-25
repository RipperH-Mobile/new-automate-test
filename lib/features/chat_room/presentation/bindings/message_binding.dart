import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/domain/use_cases/react_message_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_container_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/message_reaction_controller.dart';
import 'package:uchat/features/chat_room/presentation/bindings/base_message_binding.dart';

/// MessageBinding manages the lifecycle of message controllers using GetX dependency injection.
///
/// This class has been refactored to centralize tag generation logic for better maintainability
/// and consistency. Instead of hardcoding tag strings throughout the class, we now use helper
/// methods to generate tags systematically.
///
/// ## Key Benefits of the Refactoring:
/// - **Consistency**: All tags are generated using the same pattern
/// - **Maintainability**: Changes to tag format only need to be made in one place
/// - **Extensibility**: Easy to add suffixes or modify tag generation logic
/// - **Error Prevention**: Reduces the risk of tag mismatch between put() and close() operations
/// - **Reusability**: Tag generation methods can be used by other components
///
/// ## Usage:
/// ```dart
/// // Put a message controller (standard usage)
/// MessageBinding.put(message);
///
/// // Put a message controller with suffixes
/// MessageBinding.put(message, containerSuffix: 'thread', messageTypeSuffix: 'preview');
///
/// // Get the tag for a message (useful for finding controllers)
/// String tag = MessageBinding.getMessageTypeTag(message);
///
/// // Close a message controller (standard usage)
/// MessageBinding.close(message);
///
/// // Close a message controller with suffixes (must match put() suffixes)
/// MessageBinding.close(message, containerSuffix: 'thread', messageTypeSuffix: 'preview');

class MessageBinding extends BaseMessageBinding {
  // Expose BaseMessageBinding static methods
  static String getMessageTypeTag(MessageCollection message) {
    return BaseMessageBinding.getMessageTypeTag(message);
  }

  static String getMessageTypeTagWithSuffix(MessageCollection message, String suffix) {
    return BaseMessageBinding.getMessageTypeTagWithSuffix(message, suffix);
  }

  static String getContainerTag(MessageCollection message) {
    return BaseMessageBinding.getContainerTag(message);
  }

  static String getContainerTagWithSuffix(MessageCollection message, String suffix) {
    return BaseMessageBinding.getContainerTagWithSuffix(message, suffix);
  }

  static String generateContainerTag(MessageCollection message, {String? suffix}) {
    return BaseMessageBinding.generateContainerTag(message, suffix: suffix);
  }

  static String generateMessageTypeTag(MessageCollection message, {String? suffix}) {
    return BaseMessageBinding.generateMessageTypeTag(message, suffix: suffix);
  }

  static void put(
    MessageCollection message, {
    String? containerSuffix,
    String? messageTypeSuffix,
    bool reactMessage = true,
  }) {
    Get.put<MessageContainerController>(
      MessageContainerController(initMessage: message),
      tag: BaseMessageBinding.generateContainerTag(message, suffix: containerSuffix),
      permanent: true,
    );

    _putMessageType(
      message,
      suffix: messageTypeSuffix,
      reactMessage: reactMessage,
    );
  }

  static void close(MessageCollection message, {String? containerSuffix, String? messageTypeSuffix}) {
    Get.delete<MessageContainerController>(
      tag: BaseMessageBinding.generateContainerTag(message, suffix: containerSuffix),
      force: true,
    );

    _closeMessageType(message, suffix: messageTypeSuffix);

    if (message.replyMessage != null) {
      final replyCollection = message.replyMessage!.toCollection();
      final replySuffix = 'reply-${message.ref}';
      _closeMessageType(replyCollection, suffix: replySuffix);
    }
  }

  static bool canReact(MessageCollection message) {
    if (message.type == null) {
      return false;
    }

    return ![
      MessageType.system,
      MessageType.callMsg,
      MessageType.remove,
      MessageType.removeOthers,
      MessageType.album,
    ].contains(message.type);
  }

  static void _putMessageType(
    MessageCollection message, {
    String? suffix,
    bool reactMessage = true,
  }) {
    if (message.type == null) {
      return;
    }

    if (canReact(message) && reactMessage) {
      Get.put<MessageReactionController>(
        MessageReactionController(
          initMessage: message,
          reactMessageUseCase: GetIt.I<ReactMessageUseCase>(),
          log: GetIt.I<LoggerService>(),
        ),
        tag: BaseMessageBinding.generateMessageTypeTag(message, suffix: suffix),
        permanent: true,
      );
    }

    // Use the shared implementation from base class
    BaseMessageBinding.putMessageTypeControllers(message, suffix: suffix);
  }

  static void _closeMessageType(MessageCollection message, {String? suffix}) {
    if (message.type == null) {
      return;
    }

    final messageTypeTag = BaseMessageBinding.generateMessageTypeTag(message, suffix: suffix);

    if (canReact(message)) {
      Get.delete<MessageReactionController>(tag: messageTypeTag, force: true);
    }

    // Use the shared implementation from base class
    BaseMessageBinding.closeMessageTypeControllers(message, suffix: suffix);
  }
}
