import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

/// This Entity represent one selected message to share in chat room.
class ShareMessageSelectionEntity {
  /// The data of a message in chat room. This will be used to in use case to send to server.
  MessageCollection message;

  /// Files to share for message that have files in it [MessageType.file], [MessageType.audio],
  /// [MessageType.video], [MessageType.image]
  /// For these message type if file id is missing, The shared message will not have file in it.
  List<String>? fileIdList;

  ShareMessageSelectionEntity({
    required this.message,
    this.fileIdList,
  });
}
