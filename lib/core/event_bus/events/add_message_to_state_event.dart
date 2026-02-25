import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class AddMessageToStateEvent {
  MessageCollection message;
  List<String> localFile;

  AddMessageToStateEvent({
    required this.message,
    this.localFile = const [],
  });

  @override
  String toString() => 'AddMessageToStateEvent(message: $message, localFileCount: ${localFile.length})';
}
