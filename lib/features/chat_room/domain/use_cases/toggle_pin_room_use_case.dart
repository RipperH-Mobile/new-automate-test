import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_pin_room_request.dart';
import 'package:uchat/features/chat_room/domain/params/toggle_pin_room_params.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class TogglePinRoomUseCase extends SimpleUseCase<RoomSubscriptionEntity?, TogglePinRoomParams> {
  final ChatRoomListServerRepository chatRoomListServerRepository;
  final RoomSubLocalRepository roomSubLocalRepository;

  TogglePinRoomUseCase({
    required this.chatRoomListServerRepository,
    required this.roomSubLocalRepository,
  });

  @override
  Future<RoomSubscriptionEntity?> call(TogglePinRoomParams params) async {
    try {
      final roomSub = await chatRoomListServerRepository.togglePinRoom(TogglePinRoomRequest(
        roomId: params.roomId,
        isPinned: params.isPinned,
      ));
      if (roomSub != null) {
        // Create a new entity with updated isPinned value
        final updatedRoomSub = roomSub.copyWith(isPinned: params.isPinned);
        await roomSubLocalRepository.putRoomSubscription(updatedRoomSub);
      }
      return roomSub;
    } on ApiException catch (e) {
      /// Handle the case where the secret room is already expired (and server already remove that room data on server side)
      /// so pin chat room can't be done on server but on this device can still see the secret room and should be able
      /// to be pinned or unpinned.
      if (params.isSecretRoom == true && e.type == 'ERR_ROOM_SUBSCRIPTION_NOT_FOUND') {
        final localRoomSubData = await roomSubLocalRepository.getRoomSubscriptionWithRoomId(params.roomId);
        if (localRoomSubData != null) {
          // Create a new entity with updated isPinned value
          final updatedRoomSub = localRoomSubData.copyWith(isPinned: params.isPinned);
          final response = await roomSubLocalRepository.putRoomSubscription(updatedRoomSub);
          if (response != null) {
            eventBus.fire(
              RoomUpdateSubscriptionEvent(
                roomSubscription: response,
              ),
            );

            return response;
          }
        }
        return localRoomSubData;
      } else {
        rethrow;
      }
    }
  }
}
