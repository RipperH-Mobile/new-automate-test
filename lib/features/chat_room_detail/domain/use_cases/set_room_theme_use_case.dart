import 'package:get_it/get_it.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/set_room_theme_request.dart';
import 'package:uchat/features/chat_room_detail/domain/events/room_theme_updated_event.dart';
import 'package:uchat/features/chat_room_detail/domain/params/set_room_theme_params.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SetRoomThemeUseCase extends SimpleUseCase<void, SetRoomThemeParams> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  RoomSubLocalRepository get roomSubLocalRepository {
    return GetIt.I<RoomSubLocalRepository>();
  }

  @override
  Future<void> call(SetRoomThemeParams params) async {
    await chatRoomDetailServerRepository.setRoomTheme(SetRoomThemeRequest(
      roomId: params.roomId,
      theme: params.theme,
    ));

    final roomSub = await roomSubLocalRepository.getRoomSubscriptionWithRoomId(params.roomId);
    if (roomSub != null) {
      final updatedRoomSub = roomSub.copyWith(theme: int.tryParse(params.theme));
      roomSubLocalRepository.putRoomSubscription(updatedRoomSub);

      eventBus.fire(RoomThemeUpdatedEvent(
        theme: params.theme,
      ));
    }
  }
}
