import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';

class FindSearchMessageParam {
  final MessageEntity message;
  final String roomId;

  FindSearchMessageParam({required this.message, required this.roomId});
}
