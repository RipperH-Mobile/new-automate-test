import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';

class UpdateLocalMessageReactionRequest {
  final String msgId;
  final String roomId;
  final List<MessageReactionEntity> reactions;

  UpdateLocalMessageReactionRequest({
    required this.msgId,
    required this.roomId,
    required this.reactions,
  });
  
}
