import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class TriggerOfflineQueueUseCase extends SimpleUseCase<void, NoParams> {
  TriggerOfflineQueueUseCase({
    required this.chatRoomServerRepository,
  });

  final ChatRoomServerRepository chatRoomServerRepository;

  @override
  Future<void> call(NoParams params) {
    return chatRoomServerRepository.triggerOfflineQueue();
  }
}
