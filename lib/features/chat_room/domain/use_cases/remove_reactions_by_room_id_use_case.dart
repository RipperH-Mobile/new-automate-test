import 'package:uchat/features/chat_room/data/models/requests/remove_reactions_in_room_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RemoveReactionsByRoomIdUseCase extends SimpleUseCase<void, RemoveReactionsByRoomIdRequest> {
  RemoveReactionsByRoomIdUseCase({
    required this.messageLocalRepository,
  });

  final MessageLocalRepository messageLocalRepository;

  @override
  Future<void> call(RemoveReactionsByRoomIdRequest params) async {
    return messageLocalRepository.removeReactionsByRoomId(params);
  }
}
