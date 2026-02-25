import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UnpinAllMessagesInRoomUseCase extends SimpleUseCase<void, UnpinAllMessagesRequest> {
  UnpinAllMessagesInRoomUseCase({
    required this.pinMessageLocalRepository,
    required this.pinMessageServerRepository,
  });

  final PinMessageLocalRepository pinMessageLocalRepository;
  final PinMessageServerRepository pinMessageServerRepository;

  @override
  Future<void> call(UnpinAllMessagesRequest request) async {
    await pinMessageServerRepository.unpinAllMessages(request);
    await pinMessageLocalRepository.unpinAllMessagesInRoom(request);
  }
}
