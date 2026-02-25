import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class AcceptRoomHandleJoinGroupUseCase extends SimpleUseCase<dynamic, AcceptGroupInviteRequest> {
  final ChatRoomLocalCompatRepository chatRoomLocalRepository;
  final ChatRoomListServerRepository chatRoomListServerRepository;

  AcceptRoomHandleJoinGroupUseCase({
    required this.chatRoomLocalRepository,
    required this.chatRoomListServerRepository,
  });

  @override
  Future<void> call(AcceptGroupInviteRequest params) async {
    await chatRoomListServerRepository.acceptRoom(params);

    eventBus.fire(AcceptRequestEvent(id: params.roomId));

    final response = await chatRoomLocalRepository.getRoom(params.roomId);
    if (response != null) {
      final entity = response.copyWith(
        isJoined: true,
      );
      await chatRoomLocalRepository.putOrUpdateRoom(entity);
      eventBus.fire(RequireGroupInviteUpdateEvent());
    }
  }
}
