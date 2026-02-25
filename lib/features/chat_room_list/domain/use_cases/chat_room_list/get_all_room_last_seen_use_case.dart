import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_all_room_last_seen_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllRoomLastSeenParams {
  final Function(RoomUpdateEvent) onRoomUpdateEvent;
  final Function(RoomCollection) onUpdateOnlineStatus;

  const GetAllRoomLastSeenParams({
    required this.onRoomUpdateEvent,
    required this.onUpdateOnlineStatus,
  });
}

class GetAllRoomLastSeenUseCase extends SimpleUseCase<dynamic, GetAllRoomLastSeenParams> {
  final ConfigDb configDb;
  final ChatRoomLocalCompatRepository chatRoomLocalRepository;
  final ChatRoomListServerRepository chatRoomListServerRepository;

  GetAllRoomLastSeenUseCase({
    required this.configDb,
    required this.chatRoomLocalRepository,
    required this.chatRoomListServerRepository,
  });

  @override
  Future<void> call(GetAllRoomLastSeenParams params) async {
    final key = ConfigDb.getAllRoomLastSeenLastSyncConfigKey();
    await configDb.authenticated.saveConfig(
      key: key,
      value: DateTime.now(),
    );
    final lastSyncAt = await configDb.authenticated.getDateTime(
      key: key,
    );

    final request = GetAllRoomLastSeenRequest(lastSyncAt: lastSyncAt);

    final responseEntities = await chatRoomListServerRepository.getAllRoomLastSeen(request);

    if (responseEntities != null) {
      for (final entity in responseEntities) {
        final room = await chatRoomLocalRepository.getRoom(entity.roomId);

        if (room == null) continue;

        // Get member entities directly from the entity
        final memberEntities = entity.members;
        final roomCollection = room.toCollection();

        await chatRoomLocalRepository.updateAllRoomMember(memberEntities);

        params.onRoomUpdateEvent(RoomUpdateEvent(room: roomCollection));
        params.onUpdateOnlineStatus(roomCollection);
      }
    }
  }
}
