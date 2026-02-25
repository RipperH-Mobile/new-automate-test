import 'package:uchat/features/chat_room/data/models/requests/read_message_request.dart';
import 'package:uchat/features/chat_room/domain/params/trigger_read_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class TriggerReadMessageUseCase extends SimpleUseCase<void, TriggerReadMessageParams> {
  TriggerReadMessageUseCase({
    required this.chatRoomServerRepository,
  });

  final ChatRoomServerRepository chatRoomServerRepository;

  @override
  Future<void> call(TriggerReadMessageParams params) async {
    await chatRoomServerRepository.triggerReadMessage(ReadMessageRequest(
      roomId: params.roomId,
      seenMessageAt: params.seenMessageAt,
    ));
  }
}
