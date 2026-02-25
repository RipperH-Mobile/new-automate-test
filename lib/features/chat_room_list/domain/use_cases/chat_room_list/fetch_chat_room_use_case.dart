import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchChatRoomUseCase extends SimpleUseCase<RoomEntity?, String> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  ChatRoomLocalRepository get _chatRoomLocalRepository {
    return GetIt.I<ChatRoomLocalRepository>();
  }

  @override
  Future<RoomEntity?> call(String params) async {
    final response = await _chatRoomListServerRepository.fetchChatRoom(params);

    if (response != null) {
      // Get the room collection from the local repository to update it
      final roomCollection = await _chatRoomLocalRepository.getRoom(response.id);
      if (roomCollection != null) {
        await _chatRoomLocalRepository.putOrUpdateRoom(roomCollection);
      }
    }
    return response;
  }
}
