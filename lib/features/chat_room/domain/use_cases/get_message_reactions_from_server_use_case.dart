import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_message_react_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_local_message_reaction_request.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetMessageReactionsFromServerUseCase
    extends SimpleUseCase<PaginationPayload<MessageReactionEntity>, GetMessageReactRequest> {
  final MessageLocalRepository messageLocalRepository;
  final MessageServerRepository messageServerRepository;

  GetMessageReactionsFromServerUseCase({
    required this.messageLocalRepository,
    required this.messageServerRepository,
  });

  @override
  Future<PaginationPayload<MessageReactionEntity>> call(GetMessageReactRequest request) async {
    final messageReaction = await messageServerRepository.getMessageReact(request);

    final data = messageReaction.data;
    if (data == null) {
      throw Exception('No data received from server');
    }
    // Update local database with the fetched reactions
    messageLocalRepository.updateLocalMessageReaction(
      UpdateLocalMessageReactionRequest(
        msgId: request.msgId,
        roomId: request.roomId,
        reactions: data.toList(),
      ),
    );

    return messageReaction;
  }
}
