import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class MessageSelection {
  MessageCollection message;
  int? subMessageIndexRef;

  MessageSelection({required this.message, this.subMessageIndexRef});
}
