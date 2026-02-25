import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class MessageUpdateEvent {
  MessageCollection message;

  MessageUpdateEvent({required this.message});

  @override
  String toString() => 'MessageUpdateEvent(message: $message)';
}
