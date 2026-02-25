import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_hide_room_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ToggleHideRoomUseCase extends SimpleUseCase<dynamic, ToggleHideRoomRequest> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  ChatRoomLocalRepository get _chatRoomLocalRepository {
    return GetIt.I<ChatRoomLocalRepository>();
  }

  @override
  Future<void> call(ToggleHideRoomRequest params) async {
    final roomSubscriptionEntity = await _chatRoomListServerRepository.toggleHideRoom(params);
    if (roomSubscriptionEntity != null) {
      await _chatRoomLocalRepository.updateRoomSubscription(roomSubscriptionEntity);
    }
  }
}
