import 'package:flutter/widgets.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:super_sliver_list/super_sliver_list.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/utils/date.dart';

class MessageSliverListEntity {
  /// The date of the messages in this group
  ///
  /// This date is used to display the date header in the list view.
  final DateTime date;

  /// The list of messages in this group of the date
  ///
  /// The messages are sorted in ascending order by their sequence number.
  /// The first message in the list is the newest message, and the last message in the list is the oldest message.
  final List<MessageCollection> messages;

  /// The callback function to be called when the list view is attached to the widget tree
  final VoidCallback? onListAttached;

  /// The callback function to be called when the list view is detached from the widget tree
  final VoidCallback? onListDetached;

  /// The scroll controller for the list view
  ///
  /// This controller is used to control the scroll behavior of the list view.
  /// It is used to scroll to a specific item in the list view or get the visible item range.
  final ScrollController scrollController;

  MessageSliverListEntity({
    required this.date,
    required this.scrollController,
    this.messages = const [],
    this.onListAttached,
    this.onListDetached,
  }) {
    // Initialize the list controller for the list view
    listController = ListController(
      onAttached: () {
        eventBus.fire(MessageListAttachedEvent(messageSliverKey: keyEntity, isAttached: true));
        onListAttached?.call();
      },
      onDetached: () {
        eventBus.fire(MessageListAttachedEvent(messageSliverKey: keyEntity, isAttached: false));
        onListDetached?.call();
      },
    );
  }

  /// Generate the key for this group of messages
  ///
  /// **This function can use static to make it easier to call without creating an instance of the class.**
  ///
  /// This key is used to identify this group of messages in the list view.
  ///
  /// The key is the `milliseconds since epoch of the date` of the messages.
  ///
  /// Example: If the date is `2022-01-01`, the key will be `1640995200000`.
  ///
  /// [messageDateTime] The date of the messages example: message.createdAt
  static int generateKeyEntity(DateTime messageDateTime) {
    final messageDate = messageDateTime.startOfDay;
    return messageDate.millisecondsSinceEpoch;
  }

  /// The key for this group of messages in the list view
  ///
  /// This key is used to identify this group of messages in the list view.
  ///
  /// The key is the `milliseconds since epoch of the date` of the messages.
  ///
  /// Example: If the date is `2022-01-01`, the key will be `1640995200000`.
  int get keyEntity {
    final messageDate = DateTime(date.year, date.month, date.day);
    return messageDate.millisecondsSinceEpoch;
  }

  /// The controller for the list view
  ///
  /// This controller is used to control the list view, such as scrolling to a specific item
  /// or getting the visible item range.
  late ListController listController;

  /// Get the visible item range in the message list view
  (int, int)? get visibleItemRange => listController.visibleRange;

  /// Get the index of the first visible item in the message list view
  int get fromVisibleItemIndex => visibleItemRange?.$1 ?? 0;

  /// Get the index of the last visible item in the message list view
  int get toVisibleItemIndex => visibleItemRange?.$2 ?? 0;

  /// Get the first message in this group of messages, which is the first (bottom) message in the list
  int get newestMessageSequence => messages.first.sequence ?? 0;

  /// Get the last message in this group of messages, which is the last (top) message in the list
  int get oldestMessageSequence => messages.last.sequence ?? 0;

  /// Get the first message in this group of messages, which is the first (bottom) message in the list
  MessageCollection get newestMessage => messages.first;

  /// Get the last message in this group of messages, which is the last (top) message in the list
  MessageCollection get oldestMessage => messages.last;

  void close() {
    listController.dispose();
  }

  @override
  String toString() => 'MessageSliverListEntity(date: $date, messages length: ${messages.length})';

  /// Find a message by its sequence number
  ///
  /// If the message is not found, return null
  ///
  /// [sequence] The sequence number of the message
  MessageCollection? findMessageBySequence(int sequence) {
    return messages.firstWhereOrNull((element) => element.sequence == sequence);
  }

  /// Find the index of a message by its sequence number
  ///
  /// If the message is not found, return -1
  ///
  /// [sequence] The sequence number of the message
  int findMessageIndexBySequence(int? sequence) {
    if (sequence == null) {
      return -1;
    }

    return messages.indexWhere((element) => element.sequence == sequence);
  }

  /// Sort the messages by their sequence number
  ///
  /// This method is used to sort the messages in ascending order by their sequence number.
  /// It is useful when the messages are not in order, such as when new messages are added to the list.
  void sortMessages() {
    messages.sort((a, b) => a.sequence!.compareTo(b.sequence!));
  }

  /// Put a message in the list
  ///
  /// This method puts a message in the list and notifies the list view to update the UI.
  ///
  /// - If the message is already in the list, update it
  /// - If the new message has a sequence number, find the index to insert the new message
  /// - If the new message has no sequence number, insert it at the beginning of the list
  ///
  /// [message] The message to be put in the list
  /// [onMessageUpdated] The callback function to be called after the message is updated
  void putMessage(MessageCollection message, {VoidCallback? onMessageUpdated}) {
    // If the message is already in the list, update it
    final index = findMessageIndexBySequence(message.sequence);
    if (index != -1) {
      messages[index].update(message);
      onMessageUpdated?.call();
      if (listController.isAttached) {
        listController.addItem(index);
      }
      return;
    }

    // This is the default index to insert the new message
    // If the new message has a sequence number, find the index to insert the new message
    // But if the new message has no sequence number, insert it at the beginning of the list
    int insertAtIndex = 0;

    // The last index of the list
    final lastIndex = messages.length - 1;
    final newMessageSequence = message.sequence;

    if (newMessageSequence != null) {
      /// Find the index to insert the new message
      for (var i = 0; i < messages.length; i++) {
        final messageSequence = messages[i].sequence;

        // If message length is more than 1 and the last index is the same as i
        if (messages.length > 1 && lastIndex == i) {
          insertAtIndex = i + 1;
          break;
        }

        // If the message has a sequence number, and messageSequence is older than newMessageSequence
        // Insert the new message before it
        if (messageSequence != null && messageSequence < newMessageSequence) {
          insertAtIndex = i;
          break;
        }
      }
    }

    messages.insert(insertAtIndex, message);
    onMessageUpdated?.call();
    if (listController.isAttached) {
      listController.addItem(insertAtIndex);
    }
  }

  /// Add a new message to the list
  ///
  /// This method adds a new message to the list and notifies the list view to update the UI.
  /// The new message is added to the bottom of the list, so it is the first item in the list view.
  void addNewerMessage(MessageCollection message) {
    messages.insert(0, message);
    if (listController.isAttached) {
      listController.addItem(0);
    }
  }

  /// Add a list of new messages to the list
  ///
  /// This method adds a list of new messages to the list and notifies the list view to update the UI.
  /// The new messages are added to the bottom of the list, so they are the first items in the list view.
  void addNewerMessages(List<MessageCollection> messages) {
    this.messages.insertAll(0, messages);
    if (listController.isAttached) {
      listController.addItem(0);
    }
  }

  /// Add an older message to the list
  ///
  /// This method adds an older message to the list and notifies the list view to update the UI.
  /// The older message is added to the top of the list, so it is the last item in the list view.
  void addOlderMessage(MessageCollection message) {
    messages.add(message);
    if (listController.isAttached) {
      listController.addItem(messages.length - 1);
    }
  }

  /// Add a list of older messages to the list
  ///
  /// This method adds a list of older messages to the list and notifies the list view to update the UI.
  /// The older messages are added to the top of the list, so they are the last items in the list view.
  void addOlderMessages(List<MessageCollection> messages) {
    this.messages.addAll(messages);
    if (listController.isAttached) {
      listController.addItem(this.messages.length - messages.length);
    }
  }

  /// Remove a message from the list by its sequence number
  ///
  /// This method removes a message from the list by its sequence number and notifies the list view to update the UI.
  /// If the message is not found, this method does nothing.
  ///
  /// [sequence] The sequence number of the message to be removed
  void removeMessageBySequence(int sequence, {VoidCallback? onMessageUpdated}) {
    final index = findMessageIndexBySequence(sequence);

    if (index == -1) {
      return;
    }

    messages.removeAt(index);
    onMessageUpdated?.call();
    if (listController.isAttached) {
      listController.removeItem(index);
    }
  }

  /// Update a message in the list
  ///
  /// This method updates a message in the list and notifies the list view to update the UI.
  /// If the message is not found, this method does nothing.
  ///
  /// [message] The updated message
  /// [onMessageUpdated] The callback function to be called after the message is updated
  void updateMessage(MessageCollection message, VoidCallback? onMessageUpdated) {
    final index = messages.indexWhere((element) => element.sequence == message.sequence);
    if (index != -1) {
      messages[index] = message;
      onMessageUpdated?.call();
    }
  }

  /// Update a list of messages in the list
  ///
  /// This method updates a list of messages in the list and notifies the list view to update the UI.
  /// If the message is not found, this method does nothing.
  ///
  /// [messages] The updated messages
  /// [onMessageUpdated] The callback function to be called after the messages are updated
  void updateMessages(List<MessageCollection> messages, VoidCallback? onMessageUpdated) {
    for (final message in messages) {
      final index = this.messages.indexWhere((element) => element.sequence == message.sequence);
      if (index != -1) {
        this.messages[index] = message;
      }
    }
    onMessageUpdated?.call();
  }

  /// Clear all messages in the list
  void clear() {
    messages.clear();
  }

  /// Get the date header for the list of messages
  ///
  /// The date header is used to display the date of the messages in the list.
  ///
  /// If the date is today, the header will be 'Today'.
  ///
  /// If the date is yesterday, the header will be 'Yesterday'.
  ///
  /// Otherwise, the header will be the date in the format 'MMM dd, yyyy'.
  String get dateHeader {
    if (date.isToday) {
      return 'Today'.tr;
    } else if (date.isYesterday) {
      return 'Yesterday';
    } else {
      return date.format('MMM dd, yyyy');
    }
  }

  /// Scroll to a message in the list
  ///
  /// This method scrolls to a message in the list by its sequence number.
  /// If the message is not found, this method does nothing.
  ///
  /// [sequence] The sequence number of the message to scroll to
  /// [animate] Whether to animate the scroll or jump to the message
  ///
  /// The alignment of the item on the screen after animate or jump to the item, and show the item in the middle of the screen
  void scrollToMessage(
    int index, {
    bool animate = true,
    double alignment = 0.5,
    Duration animateDuration = const Duration(milliseconds: 500),
  }) {
    if (index == -1) {
      return;
    }

    if (animate) {
      listController.animateToItem(
        index: index,
        scrollController: scrollController,
        alignment: alignment,
        duration: (_) => animateDuration,
        curve: (_) => Curves.easeInOut,
      );
    } else {
      listController.jumpToItem(
        index: index,
        scrollController: scrollController,
        alignment: alignment,
      );
    }
  }
}
