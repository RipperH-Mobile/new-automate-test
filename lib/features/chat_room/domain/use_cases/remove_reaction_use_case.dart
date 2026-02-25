import 'package:uchat/features/chat_room/data/models/requests/remove_reaction_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RemoveReactionUseCase extends SimpleUseCase<void, RemoveReactionRequest> {
  RemoveReactionUseCase({
    required this.messageLocalRepository,
  });

  final MessageLocalRepository messageLocalRepository;

  @override
  Future<void> call(RemoveReactionRequest params) async {
    return messageLocalRepository.removeReaction(params);
  }
}
