import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_mute_room_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/params/toggle_mute_room_params.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ToggleMuteRoomUseCase extends SimpleUseCase<bool?, ToggleMuteRoomParams> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  ChatRoomLocalRepository get _chatRoomLocalRepository {
    return GetIt.I<ChatRoomLocalRepository>();
  }

  @override
  Future<bool?> call(ToggleMuteRoomParams params) async {
    final response = await _chatRoomListServerRepository.toggleMutedRoom(ToggleMuteRoomRequest(
      roomId: params.roomId,
      isMuted: params.isMuted,
    ));
    if (response != null) {
      final updateRoomSubData = RoomSubscriptionCollection(
        id: response.id,
        roomId: response.roomId,
        isMuted: response.isMuted,
      );

      await _chatRoomLocalRepository.updateRoomSubscription(updateRoomSubData.toEntity());
    }

    return response?.isMuted ?? false;
  }
}
