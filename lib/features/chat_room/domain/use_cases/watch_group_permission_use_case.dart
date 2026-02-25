import 'dart:async';

import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/params/group_permission_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';

class WatchGroupPermissionUseCase {
  final ChatRoomLocalRepository localRepository;

  WatchGroupPermissionUseCase({
    required this.localRepository,
  });

  Stream<GroupPermissionEntity> call(WatchGroupPermissionParams params) {
    return localRepository.watchGroupPermission(params.roomId);
  }
}