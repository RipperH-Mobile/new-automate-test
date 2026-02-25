import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class JumpToMessageEvent {
  final MessageCollection message;
  final String roomId;
  final bool shakeMessage;

  const JumpToMessageEvent({
    required this.message,
    required this.roomId,
    this.shakeMessage = false,
  });

  @override
  String toString() => 'JumpToMessageEvent(message: $message, roomId: $roomId)';
}
