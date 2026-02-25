import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

/// Parameter class for deleting messages
class DeleteMessageParams {
  DeleteMessageParams({
    required this.roomId,
    required this.messages,
  });

  /// ID of the chat room
  final String roomId;

  // List of selected messages
  final List<MessageCollection> messages;
}
