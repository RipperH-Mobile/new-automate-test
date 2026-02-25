import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/utils/nullable_utils.dart';

class UpdateDraftMessageParams {
  final String roomId;

  UpdateDraftMessageParams({
    required this.roomId,
  });
}

class UpdateDraftMessageUseCase extends SimpleUseCase<RoomEntity?, NoParams> {
  final LoggerService log;
  final ChatRoomLocalCompatRepository chatRoomLocalRepository;
  final MessageLocalRepository messageLocalRepository;

  UpdateDraftMessageUseCase({
    required this.log,
    required this.chatRoomLocalRepository,
    required this.messageLocalRepository,
  });

  @override
  Future<RoomEntity?> call(NoParams params) async {
    final draftMessage = await messageLocalRepository.getDraftMessage();

    if (draftMessage == null) {
      // log.w('No draft message found');
      return null;
    }

    final roomId = draftMessage.roomId;
    final room = await chatRoomLocalRepository.getRoom(roomId);
    if (room == null) {
      log.w('Room not found for ID: $roomId');
      return null;
    }

    final updatedRoom = room.copyWith(
      draftMessage: draftMessage.message,
      draftReplyMessage: Nullable.value(draftMessage.replyMessage),
    );
    await chatRoomLocalRepository.putRoom(updatedRoom, replaceData: true);

    // Clear the draft message after updating the room
    messageLocalRepository.clearDraftMessage();

    return updatedRoom;
  }
}
