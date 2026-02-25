import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

/// Parameter class for unsending messages (removing messages for sender)
class UnsentMessageParams {
  UnsentMessageParams({
    required this.roomId,
    required this.messages,
  });

  /// ID of the chat room
  final String roomId;

  /// List of messages
  final List<MessageCollection> messages;
}
