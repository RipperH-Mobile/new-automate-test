import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/data/models/requests/watch_pin_messages_in_room_local_request.dart';

class WatchPinMessagesInRoomParams {
  final String roomId;
  final int? pageSize;

  WatchPinMessagesInRoomParams({
    required this.roomId,
    this.pageSize,
  });
}

class WatchPinMessagesInRoomUseCase  {
  WatchPinMessagesInRoomUseCase({
    required this.pinMessageRepository,
  });

  final PinMessageLocalRepository pinMessageRepository;

  Stream<PaginationPayload<PinMessageEntity>> call(WatchPinMessagesInRoomParams params) {
    return pinMessageRepository.watchPinMessagesInRoom(
      WatchPinMessagesInRoomLocalRequest(
        roomId: params.roomId,
        pageSize: params.pageSize,
      ),
    );
  }
}
