import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';

class SearchMessagesResultModel {
  RoomCollection room;
  int foundMessageCount;

  SearchMessagesResultModel({
    required this.room,
    required this.foundMessageCount,
  });
}
