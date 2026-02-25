import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';

class GetGroupPermissionUseCase extends SimpleUseCase<GroupPermissionEntity?, GetGroupPermissionParams> {
  final ChatRoomLocalRepository localRepository;
  final ChatRoomServerRepository serverRepository;

  GetGroupPermissionUseCase({
    required this.localRepository,
    required this.serverRepository,
  });

  @override
  Future<GroupPermissionEntity?> call(GetGroupPermissionParams params) async {
    try {
      if (params.persistences.contains(GroupPermissionPersistence.server)) {
        final serverPermission =
            await serverRepository.getGroupPermission(params.roomId) ?? GroupPermissionEntity(roomId: params.roomId);
        await localRepository.updateGroupPermission(serverPermission);
        return serverPermission;
      }

      return await localRepository.getGroupPermission(params.roomId);
    } catch (_) {
      return await localRepository.getGroupPermission(params.roomId);
    }
  }
}
