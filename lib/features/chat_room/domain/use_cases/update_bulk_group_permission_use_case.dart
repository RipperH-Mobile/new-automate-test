import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';

class UpdateBulkGroupPermissionUseCase
    extends SimpleUseCase<List<GroupPermissionEntity>, UpdateBulkGroupPermissionParams> {
  final ChatRoomLocalRepository localRepository;
  final ChatRoomServerRepository serverRepository;

  UpdateBulkGroupPermissionUseCase({
    required this.localRepository,
    required this.serverRepository,
  });

  @override
  Future<List<GroupPermissionEntity>> call(UpdateBulkGroupPermissionParams params) async {
    final permissions = await Future.wait(
      params.permissions.map((permission) async {
        final entity = await localRepository.getGroupPermission(permission.roomId);
        return permission.copyWith(
          createdAt: entity?.createdAt ?? DateTime.now(),
          updatedAt: DateTime.now(),
        );
      }),
    );

    if (params.persistences.contains(GroupPermissionPersistence.server)) {
      for (final permission in permissions) {
        await serverRepository.updateGroupPermission(permission);
      }
    }

    if (params.persistences.contains(GroupPermissionPersistence.local)) {
      await localRepository.updateGroupPermissions(permissions);
    }

    return permissions;
  }
}
