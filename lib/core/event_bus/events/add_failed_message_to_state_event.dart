import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class AddFailedMessageToStateEvent {
  final MessageCollection message;
  final bool isNewMessage;

  AddFailedMessageToStateEvent({
    required this.message,
    this.isNewMessage = false,
  });

  @override
  String toString() => 'AddFailedMessageToStateEvent(message: $message, isNewMessage: $isNewMessage)';
}
