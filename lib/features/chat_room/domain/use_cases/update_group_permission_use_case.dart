import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';

@Deprecated('Use UpdateBulkGroupPermissionUseCase instead')
class UpdateGroupPermissionUseCase extends SimpleUseCase<GroupPermissionEntity, UpdateGroupPermissionParams> {
  final ChatRoomLocalRepository localRepository;
  final ChatRoomServerRepository serverRepository;

  UpdateGroupPermissionUseCase({
    required this.localRepository,
    required this.serverRepository,
  });

  @override
  Future<GroupPermissionEntity> call(UpdateGroupPermissionParams params) async {
    final entity = await localRepository.getGroupPermission(params.permission.roomId);
    final permission = params.permission.copyWith(
      createdAt: entity?.createdAt ?? DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (params.persistences.contains(GroupPermissionPersistence.server)) {
      await serverRepository.updateGroupPermission(permission);
    }

    if (params.persistences.contains(GroupPermissionPersistence.local)) {
      await localRepository.updateGroupPermission(permission);
    }

    return permission;
  }
}
