import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class GetMessageFromServerResponse {
  List<MessageCollection>? messages;

  GetMessageFromServerResponse({
    this.messages,
  });

  factory GetMessageFromServerResponse.fromMap(Map<String, dynamic> json) {
    List<MessageCollection> messages = [];
    final List<dynamic> messageRows = json['rows'];

    for (var messageRow in messageRows) {
      messages.add(MessageCollection.fromMap(messageRow));
    }

    return GetMessageFromServerResponse(messages: messages);
  }
}
