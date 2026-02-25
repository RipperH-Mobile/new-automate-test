import 'dart:math';

import 'package:get/get.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/presentation/bindings/message_binding.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_list_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_audio_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_file_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_image_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_video_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/utils/find_message_index.dart';

List<MessageCollection> appendOrUpdateManyMessageToState(
  List<MessageCollection> incomingMessages,
  List<MessageCollection> messages,
  int failedMessagesLength, {
  bool refreshListController = true,
  ChatScrollObserver? chatObserver,
  MessageListController? messageListController,
}) {
  // Sort the message by the sequence of the message in ascending order
  // for the message list view to display the message in the correct order
  incomingMessages.sort((a, b) {
    final aSequence = a.sequence;
    final bSequence = b.sequence;

    // If the sequence is null, then return 0, that means the message is not found
    // in the message list view
    if (aSequence == null || bSequence == null) {
      return 0;
    }

    return bSequence.compareTo(aSequence);
  });
  for (final message in incomingMessages) {
    messages = appendOrUpdateMessageToState(
      message,
      messages,
      failedMessagesLength,
      refreshListController: refreshListController,
      chatObserver: chatObserver,
      messageListController: messageListController,
    );
  }

  return messages;
}

/// Append or update message to state
///
/// This function will append or update the message to the message list.
///
/// - If the message is `coming from the server`, then find the message by the sequence of the message, then update the message.
/// - If the message is `not found`, then add the message to the message list.
/// - If the message is `failed message`, then remove the message from the message list and add it
List<MessageCollection> appendOrUpdateMessageToState(
  MessageCollection comingMessage,
  List<MessageCollection> messages,
  int failedMessagesLength, {
  bool refreshListController = true,
  ChatScrollObserver? chatObserver,
  bool isNewMsgFromServer = false,
  MessageListController? messageListController,
}) {
  final messageIndex = findMessageIndex(comingMessage, messages);
  final isSendFailed = comingMessage.isSendFailed == true;

  // To make the chat list view to standby, not moving.
  // Each message action could change list size, so should call standBy each time that make action event add 1 or many at once.
  chatObserver?.standby();

  // If the message is not found in the message list, then add the message to the message list
  if (messageIndex == -1 || isSendFailed) {
    if (isSendFailed) {
      // If the message is a failed message, then remove the message from the message list
      // And then let add the message with failed status to the message list
      removeMessageFromState(comingMessage, messages);
    }

    /// To play new message animation
    ///
    /// Let this [comingMessage] belong to deviceA
    ///
    /// If the message was sent from accountA on deviceA, the [comingMessage.id] and the [comingMessage.ref]
    /// will be the same when the message is shows on chat screen.
    /// Then the message will get the [MessageUpdateEvent] to update message id later (it's too late for animation).
    /// So the [comingMessage.id == comingMessage.ref] can indicate that this is a new message.
    ///
    /// But if the message was sent from other accounts or sent from accountA on other devices (not deviceA),
    /// the [comingMessage.id] and the [comingMessage.ref] will be different at the first place.
    /// So use the [isNewMsgFromServer] instead.
    ///
    final isNewMessage = comingMessage.id == comingMessage.ref || isNewMsgFromServer;
    if (isNewMessage && comingMessage.type != MessageType.system && !isSendFailed) {
      eventBus.fire(PlayNewMessageAnimationEvent(message: comingMessage));
    }

    return addMessageToState(
      comingMessage,
      messages,
      refreshListController: refreshListController,
      failedMessagesLength,
    );
  } else {
    return updateMessageToState(
      comingMessage,
      messages,
      messageIndex,
      refreshListController: refreshListController,
      messageListController: messageListController,
    );
  }
}

/// Find message index
///
/// This function will find the index of the message in the message list by the sequence of the message.
///
/// [comingMessage] The message that is coming from the server.
///
/// `Return an int` which is the index of the message in the message list.
int findMessageIndex(MessageCollection comingMessage, List<MessageCollection> messages) {
  return messages.indexWhere((msgElement) {
    /// If coming message `has sequence`, that means the message is `coming from the server`
    if (comingMessage.sequence != null) {
      /// This is the case when the message is coming from the server and the message is not found in the message list yet
      /// then find the message by the sequence of the message
      if (msgElement.sequence == comingMessage.sequence &&
          (msgElement.id == comingMessage.id || msgElement.ref == comingMessage.ref)) {
        return true;
      }
    }

    /// If coming message `does not have sequence`, that means the message is `not coming from the server`
    /// **then find the message by the ref of the message
    if (comingMessage.ref != null) {
      return msgElement.ref == comingMessage.ref;
    }

    // Default case, find the message by the id of the message
    return msgElement.id == comingMessage.id;
  });
}

List<MessageCollection> removeMessageFromState(MessageCollection message, List<MessageCollection> messages) {
  final messageIndex = findMessageIndex(message, messages);
  if (messageIndex == -1) {
    return messages;
  }

  messages.removeAt(messageIndex);
  MessageBinding.close(message);
  return messages;
}

/// Add message to state
///
/// This function will add the message to the message list.
///
/// - If the message is `unsent message` or `remove message`, then return.
/// - If the message is `not unsent message` or `not remove message`, then add the message to the message list.
List<MessageCollection> addMessageToState(
  MessageCollection message,
  List<MessageCollection> messages,
  int failedMessagesLength, {
  bool refreshListController = true,
}) {
  if (message.isUnsentMessage || message.isRemoveMessage) return messages;

  MessageBinding.put(message);

  int insertAtIndex;
  // If the message is a failed message, then insert the message at the bottom of the message list
  if (failedMessagesLength > 0 && message.isSendFailed == true) {
    insertAtIndex = 0;
  } else {
    insertAtIndex = findIndexToAddNewMessage(message, messages, failedMessagesLength);
  }

  if (message.replyMessage != null) {
    MessageBinding.put(
      message.replyMessage!.toCollection(),
      messageTypeSuffix: 'reply-${message.ref}',
      reactMessage: false,
    );
  }

  if (insertAtIndex < 0) {
    // POC to fix the issue of insertAtIndex < 0,
    // Please check it should return the function or assign 0 to insertAtIndex
    insertAtIndex = 0;
  }

  messages.insert(insertAtIndex, message);
  return messages;
}

/// Update message to state
///
/// This function will update the message in the message list.
///
/// - If the message is `unsent message` or `remove message`, then remove the message from the message list.
/// - If the message is `not unsent message` or `not remove message`, then update the message in the message list.
List<MessageCollection> updateMessageToState(
  MessageCollection message,
  List<MessageCollection> messages,
  int messageIndex, {
  bool refreshListController = true,
  MessageListController? messageListController,
}) {
  // Check if the message is currently showing animation
  // Queue update to prevent animation interruption
  final currentMessage = messages[messageIndex];
  if (currentMessage.ref != null) {
    if (messageListController != null &&
        messageListController.isAnimating.value &&
        messageListController.animateMessageRef.value == currentMessage.ref) {
      // Store the update for later processing
      messageListController.pendingMessageUpdates[currentMessage.ref!] = message;
      return messages; // Skip immediate update
    }
  }

  // if current message is sending and the new message is sent, close the current message controller
  //! This comment code make edit message ui not update.
  // if (currentMessage.isSending == true && message.isSent && currentMessage.ref == message.ref) {
  //   MessageBinding.close(currentMessage);
  // }

  MessageBinding.put(message);

  if (message.replyMessage != null) {
    MessageBinding.put(
      message.replyMessage!.toCollection(),
      messageTypeSuffix: 'reply-${message.ref}',
      reactMessage: false,
    );
  }
  // In case message type message unsent or remove (Not all), replace new files to the message.
  // ! TODO: Don't forget to implement
  // if (message.type == MessageType.image) {
  //   onUpdateMessageTypeImagesCtlList(message.ref!, message.files ?? []);
  // }

  if (message.type == MessageType.video || message.type == MessageType.file || message.type == MessageType.image) {
    onUpdateMessageTypeImagesCtlList(message);
  }

  if (message.isRemoveMessage) {
    MessageBinding.close(message);
    messages.removeAt(messageIndex);

    return messages;
  }

  // Because message and media can be sent at the same time, When sending media first and text message later, The text
  // message will complete first, So the text message position in the list should be on top of media message.
  // This will be used to check when sending message is completed, If the message index is changed, then move the message to the new index.
  // Otherwise the message will stay at the same index such as edit message case.
  final recheckIndex = messages[messageIndex].sequence == null && message.sequence != null;
  final newIndex = findIndexToAddNewMessage(message, messages, 0);
  messages[messageIndex].update(message);

  if (recheckIndex) {
    // newIndex is the index where the message should be inserted but old sending message has to be removed so the correct
    // new index should minus 1.
    // Example: [msg1(sending), msg2(sending), msg3]]
    // then msg1 send complete before msg2, so the newIndex of msg1(complete) is 2, but msg1(sending) has to be removed first,
    // so the correct new index to insert msg1(complete) is 1.
    // [msg2(sending), msg1(complete), msg3] after that the list should look like this.
    // then msg2 send complete, the newIndex of msg2(complete) is 1, and msg2(sending) has to be removed first,
    // so the correct new index to insert msg2(complete) is 0.
    final finalIndex = max(0, newIndex - 1); // max to prevent negative index
    if (messageIndex != finalIndex) {
      final updatedMessage = messages.removeAt(messageIndex);
      messages.insert(finalIndex, updatedMessage);
    }
  }

  return messages;
}

void onUpdateMessageTypeImagesCtlList(MessageCollection message) {
  // Guard clauses for null safety
  if (message.ref == null || message.files == null || message.files!.isEmpty || message.type == null) {
    return;
  }

  final ref = message.ref!;
  final files = message.files!;
  final typeValue = message.type!.value;
  final tag = '$typeValue-$ref';

  // Find the appropriate controller based on message type
  if (Get.isRegistered<MessageTypeImageV2Controller>(tag: tag)) {
    final ctl = Get.find<MessageTypeImageV2Controller>(tag: tag);
    ctl.messageFiles.value = updateHelper(files, ctl.messageFiles);
    ctl.messageFiles.refresh();
  } else if (Get.isRegistered<MessageTypeFileV2Controller>(tag: tag)) {
    // File messages typically do not have files to update, so no action needed here.
  } else if (Get.isRegistered<MessageTypeVideoV2Controller>(tag: tag)) {
    // Video messages typically do not have files to update, so no action needed here.
  } else if (Get.isRegistered<MessageTypeAudioV2Controller>(tag: tag)) {
    // Audio messages typically do not have files to update, so no action needed here.
  }
}

List<MessageFileModel> updateHelper(List<MessageFileModel> files, List<MessageFileModel> compareFiles) {
  List<MessageFileModel> newFiles = [];

  try {
    for (final file in files) {
      final compareFile = compareFiles.firstWhereOrNull((e) => e.refFile == file.refFile);
      if (compareFile != null) {
        // Preserve important properties from the existing file
        final temp = file.copyWith(
          assetId: compareFile.assetId,
          url: compareFile.url,
          thumbnailBytes: compareFile.thumbnailBytes,
          duration: compareFile.duration,
          width: compareFile.width,
          height: compareFile.height,
          thumbnailFileName: compareFile.thumbnailFileName,
          videoInfo: compareFile.videoInfo,
          progressState: FileProgressState.uploaded,
        );
        newFiles.add(temp);
      } else {
        // If no matching file found, use the original
        newFiles.add(file);
      }
    }
    // ctl.messageFiles.value = newFiles;
    // ctl.messageFiles.refresh();
  } catch (e, stackTrace) {
    useLogger().e('onUpdateMessageTypeImagesCtlList error.', e, stackTrace);
  }

  return newFiles;
}
