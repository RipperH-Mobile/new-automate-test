import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';

class GetGroupPermissionParams {
  final String roomId;
  final Set<GroupPermissionPersistence> persistences;

  GetGroupPermissionParams({
    required this.roomId,
    this.persistences = const {
      GroupPermissionPersistence.local,
    },
  });
}

class UpdateGroupPermissionParams {
  final GroupPermissionEntity permission;
  final Set<GroupPermissionPersistence> persistences;

  UpdateGroupPermissionParams({
    required this.permission,
    this.persistences = const {
      GroupPermissionPersistence.local,
      GroupPermissionPersistence.server,
    },
  });
}

class UpdateBulkGroupPermissionParams {
  final List<GroupPermissionEntity> permissions;
  final Set<GroupPermissionPersistence> persistences;

  UpdateBulkGroupPermissionParams({
    required this.permissions,
    this.persistences = const {
      GroupPermissionPersistence.local,
      GroupPermissionPersistence.server,
    },
  });
}

class WatchGroupPermissionParams {
  final String roomId;

  WatchGroupPermissionParams({
    required this.roomId,
  });
}

enum GroupPermissionPersistence {
  local,
  server,
}
