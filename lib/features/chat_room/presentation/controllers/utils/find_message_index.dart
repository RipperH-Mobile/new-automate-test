import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

int findIndexToAddNewMessage(
  MessageCollection message,
  List<MessageCollection> messages,
  int failedLength,
) {
  int insertAtIndex = failedLength; // if failed message is empty, initialize to 0.
  final newMessageSequence = message.sequence;

  if (newMessageSequence != null) {
    for (var i = 0; i < messages.length; i++) {
      final messageSequence = messages.elementAtOrNull(i)?.sequence;

      if (messageSequence != null && messageSequence <= newMessageSequence) {
        insertAtIndex = i;
        break;
      }

      if (i == messages.length - 1) {
        insertAtIndex = i + 1;
      }
    }
  }

  return insertAtIndex;
}
