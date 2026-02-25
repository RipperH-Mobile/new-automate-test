import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

/// For sending unlocked message data to all message that reply to [message] to
/// update ui with unlock data.
class LockMessageUnlockedEvent {
  MessageCollection message;

  LockMessageUnlockedEvent({required this.message});

  @override
  String toString() => 'LockMessageUnlockedEvent(message: $message)';
}
