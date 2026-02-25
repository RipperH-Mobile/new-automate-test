import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:scrollview_observer/scrollview_observer.dart';
import 'package:uchat/core/domain/services/life_cycle_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class TriggerReadParams {
  final List<MessageCollection> messages;
  final ListObserverController listObserverController;
  final ScrollController scrollController;
  final Future<void> Function(DateTime? messageCreatedAt) chatRoomCtlTriggerReadMessage;
  final void Function(int index)? onLastReadMessageIndexCallback;
  final bool enableReadMessage;
  final int lastReadMessageIndex;
  final RoomCollection? room;
  final int myLastReadAt;
  final (int, int)? visibleIndexRange;
  final (MessageCollection, MessageCollection)? visibleItemBorder;

  TriggerReadParams({
    required this.messages,
    required this.listObserverController,
    required this.scrollController,
    required this.chatRoomCtlTriggerReadMessage,
    required this.myLastReadAt,
    this.visibleIndexRange,
    this.enableReadMessage = true,
    this.lastReadMessageIndex = -1,
    this.room,
    this.visibleItemBorder,
    this.onLastReadMessageIndexCallback,
  });
}

/// Trigger read message
///
/// This function will trigger the read message when
/// - the user is scrolling the message list view.
/// - the user is at the bottom of the message list view.
class TriggerReadMessageV2UseCase extends SimpleUseCase<void, TriggerReadParams> {
  @override
  Future<void> call(TriggerReadParams param) async {
    if (param.room == null) {
      return;
    }

    final isNotChatScreen = Get.currentRoute != '/chat-room/direct/${param.room?.id}';

    final isAppPaused = GetIt.I<LifeCycleService>().isPaused;
    if (param.enableReadMessage == false || isNotChatScreen || isAppPaused) {
      return;
    }

    try {
      if (param.lastReadMessageIndex >= 0) {
        // If the last read message index is greater than or equal to 0, means that user has unread messages
        // To prevent trigger read message when the system is scrolling to the latest read message
        // After there is the last read message in the view port, then reset the last read message index to -1
        // to let the system trigger read message again

        // Use visibleIndexRange, because the visibleIndexRange is updated when the list view is scrolled
        final (to, from) = param.visibleIndexRange ?? (-1, -1);

        // Check if the last read message is visible in the message list view or not
        final isLastReadMessageVisible = param.lastReadMessageIndex + 1 >= to && param.lastReadMessageIndex + 1 <= from;
        if (!isLastReadMessageVisible) {
          // If the last read message is not visible in the message list view, then do nothing
          // because the system is still scrolling to the latest read message
          return;
        }
        param.onLastReadMessageIndexCallback?.call(-1);
      }

      final visibleItemInBottom = param.visibleItemBorder?.$1;
      final firstMessageInList = param.messages.firstOrNull;
      if (visibleItemInBottom == firstMessageInList) {
        // Check in case: new message is added to the room no matter the message is sent or received
        // and user stay at the bottom of the message list view, then update the last read message time

        final targetReadMessage = firstMessageInList;
        if (targetReadMessage == null) {
          // If the target read message is null, return
          // that means the message list is empty
          return;
        }

        final targetReadMessageSequence = targetReadMessage.sequence;
        if (targetReadMessageSequence == null) {
          // If the target read message sequence is null, return
          // that means the message is not sent yet
          return;
        }

        await param.chatRoomCtlTriggerReadMessage.call(targetReadMessage.createdAt);
      } else {
        // Dispatch the observe model to get the latest visible item range after new message is added to the list
        // and list view is not at the bottom
        // Set isDependObserveCallback to false to prevent the list view from scrolling to the bottom
        // when the new message is added to the list

        // Check in case: user is scrolling the message list view then update the last read message time
        // with the last message (bottom one) in the visible item range

        if (visibleItemInBottom == null) {
          return;
        }

        final visibleMessage = visibleItemInBottom;
        final targetReadMessageSequence = visibleMessage.sequence;

        if (targetReadMessageSequence == null) {
          return;
        }

        if (visibleMessage.isSendFailed == true) {
          // If the visible message is a failed message, then do not trigger read message
          return;
        }

        if (param.myLastReadAt > targetReadMessageSequence) {
          // If the last read message time is greater than the visible message created at, then do not trigger read message
          return;
        }

        await param.chatRoomCtlTriggerReadMessage.call(visibleMessage.createdAt);
      }
    } catch (e, stackTrace) {
      _log.e('triggerReadMessage error.', e, stackTrace);
    }
  }
}
