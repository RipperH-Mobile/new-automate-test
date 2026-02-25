import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

class FindLastReadMessageIndexParams {
  final List<MessageCollection> currentMessageList;
  final int lastReadAt;
  final int unreadCount;
  final String currentUserId;

  FindLastReadMessageIndexParams({
    required this.currentMessageList,
    required this.lastReadAt,
    required this.unreadCount,
    required this.currentUserId,
  });
}

class FindLastReadMessageIndexUseCase extends SimpleUseCase<(int, String), FindLastReadMessageIndexParams> {
  @override
  Future<(int, String)> call(FindLastReadMessageIndexParams params) async {
    final List<MessageCollection> currentMessageList = params.currentMessageList;
    final int myLastReadAt = params.lastReadAt;
    final int unreadCount = params.unreadCount;
    final String currentUserId = params.currentUserId;

    if (unreadCount == 0) {
      // If there is no unread message in the room, then set the last read message index to -1
      // that means the last read message is not found in the message list
      return (-1, '');
    }

    if (currentMessageList.isEmpty) {
      // If the message list is empty, then set the last read message index to -1
      // that means the last read message is not found in the message list or this room is empty
      return (-1, '');
    }

    if (unreadCount > currentMessageList.length) {
      // If the unread count is greater than the message list, then set the last read message index to -1
      // that means the last read message is not found in the first group of messages
      return (-1, '');
    }

    if (myLastReadAt == 0) {
      // If the last read message time is 0, that mean the user is not read any message in this room
      // or just joined the room, then set the last read message index to the last message in the list
      final selectedIndex = unreadCount - 1;
      final targetMsg = currentMessageList.elementAtOrNull(selectedIndex);
      final oldestMessageRef = targetMsg?.ref ?? '';
      return (selectedIndex, oldestMessageRef);
    }

    int lastReadMessageIndex = -1;
    String lastReadMessageRef = '';
    for (var i = 0; i < currentMessageList.length; i++) {
      final message = currentMessageList[i];
      if (message.accountId == currentUserId) {
        // If the message is mine, then update the last read message index to the index of the message
        // because the last read message is the last message that I sent
        int targetIndex = i - 1;
        if (targetIndex < 0) {
          break;
        }
        lastReadMessageIndex = targetIndex;
        lastReadMessageRef = currentMessageList[targetIndex].ref ?? '';
        break;
      }

      final messageTime = message.createdAt?.toLocal().millisecondsSinceEpoch ?? 0;
      if (messageTime == 0) {
        // If the message time is 0, that mean the message is not sent yet or failed to send
        // or the message is not found in the message list
        continue;
      }

      if (myLastReadAt >= messageTime) {
        // If the message is older than the last read message time, then set the last read message index to the index of the message
        int targetIndex = i - 1;
        if (targetIndex < 0) {
          targetIndex = 0;
        }
        lastReadMessageIndex = targetIndex;
        lastReadMessageRef = currentMessageList[targetIndex].ref ?? '';
        break;
      }
    }

    return (lastReadMessageIndex, lastReadMessageRef);
  }
}
