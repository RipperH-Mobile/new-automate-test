import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class PlayNewMessageAnimationEvent {
  MessageCollection message;

  PlayNewMessageAnimationEvent({required this.message});

  @override
  String toString() => 'PlayNewMessageAnimationEvent(message: $message)';
}
