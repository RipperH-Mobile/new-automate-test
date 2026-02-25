import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_pin_room_request.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class TogglePinRoomUseCase extends SimpleUseCase<RoomSubscriptionEntity?, TogglePinRoomRequest> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  ChatRoomLocalRepository get _chatRoomLocalRepository {
    return GetIt.I<ChatRoomLocalRepository>();
  }

  @override
  Future<RoomSubscriptionEntity?> call(TogglePinRoomRequest params) async {
    final roomSubscription = await _chatRoomListServerRepository.togglePinRoom(params);
    if (roomSubscription != null) {
      final updateRoomSubData = RoomSubscriptionCollection(
        id: roomSubscription.id,
        roomId: roomSubscription.roomId,
        isPinned: roomSubscription.isPinned,
      );

      await _chatRoomLocalRepository.updateRoomSubscription(updateRoomSubData.toEntity());
    }
    return roomSubscription;
  }
}
