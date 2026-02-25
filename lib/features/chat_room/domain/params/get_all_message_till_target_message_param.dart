import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class GetAllMessageTillTargetMessageParam {
  final String roomId;
  final MessageCollection message;

  GetAllMessageTillTargetMessageParam({required this.roomId, required this.message});
}
