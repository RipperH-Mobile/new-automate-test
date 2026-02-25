import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';

class JumpToMessageParams {
  final MessageEntity message;
  final String roomId;

  JumpToMessageParams({
    required this.message,
    required this.roomId,
  });
}
