import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class MessageNewEvent {
  MessageCollection message;

  MessageNewEvent({required this.message});

  @override
  String toString() => 'MessageNewEvent(message: $message)';
}
