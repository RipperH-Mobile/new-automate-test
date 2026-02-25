import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteRoomUseCase extends SimpleUseCase<dynamic, RoomCollection> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  ChatRoomLocalRepository get _chatRoomLocalRepository {
    return GetIt.I<ChatRoomLocalRepository>();
  }

  @override
  Future<void> call(RoomCollection room) async {
    try {
      await _chatRoomListServerRepository.deleteRoom(room.id!);
    } on ApiException catch (e) {
      if (e.type == 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND' && room.isSecretRoom) {
        // Delete secret chat room in local db if it's expired.
        await _chatRoomLocalRepository.deleteRoom(room.id!);
      } else {
        rethrow;
      }
    }
    // No generic catch block here; unexpected errors propagate.
  }
}
