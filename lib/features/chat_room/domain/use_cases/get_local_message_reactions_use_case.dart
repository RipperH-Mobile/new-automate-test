import 'package:uchat/features/chat_room/data/models/requests/get_local_message_reactions_request.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetLocalMessageReactionsUseCase
    extends SimpleUseCase<List<MessageReactionEntity>, GetLocalMessageReactionsRequest> {
  GetLocalMessageReactionsUseCase({
    required this.messageLocalRepository,
  });

  final MessageLocalRepository messageLocalRepository;

  @override
  Future<List<MessageReactionEntity>> call(GetLocalMessageReactionsRequest params) async {
    final result = await messageLocalRepository.getAllMessageReactionByRoomIdAndMsgId(params);
    return result ?? [];
  }
}
