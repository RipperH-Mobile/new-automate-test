import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class CallEndEvent {
  MessageCollection message;

  CallEndEvent({required this.message});

  @override
  String toString() => 'CallEndEvent(message: $message)';
}
