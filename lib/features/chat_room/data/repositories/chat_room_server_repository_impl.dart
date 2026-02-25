import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/utilities/api_fallback_helper.dart';
import 'package:uchat/entities/services/offline_task_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_socket_service.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_encryption_key_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_member_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_secret_room_encryption_key_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/read_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/send_report_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_lock_message_password_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/share_file_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_last_typed_at_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_direct_chat_response.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_system_chat_response.dart';
import 'package:uchat/features/chat_room/domain/entities/room_encryption_key_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/secret_room_encryption_key_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_response.dart';

import '../models/requests/leave_group_with_me_as_an_owner_request.dart';

class ChatRoomServerRepositoryImpl implements ChatRoomServerRepository {
  final SocketCaller socketCaller;
  final ChatRoomApiService roomApiService;
  final ChatRoomSocketService roomSocketService;
  final OfflineTaskDb offlineTaskDb;

  ChatRoomServerRepositoryImpl({
    required this.socketCaller,
    required this.roomApiService,
    required this.roomSocketService,
    required this.offlineTaskDb,
  });

  final _log = useLogger();

  @override
  Future<RoomMenuModel?> getDraftMenu(String roomId) async {
    if (socketCaller.isReadyForCall) {
      try {
        final roomCollection = await roomSocketService.getDraftMenu(roomId);
        return roomCollection!.meta?.menu;
      } catch (e, stackTrace) {
        _log.w('getDraftMenu with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final roomCollection = await roomApiService.getDraftMenu(roomId);
    return roomCollection!.meta?.menu;
  }

  @override
  Future<SecretRoomEncryptionKeyEntity?> getSecretRoomEncryptionKey(GetSecretRoomEncryptionKeyRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await roomSocketService.getSecretRoomEncryptionKey(request);
        return socketResp?.toEntity();
      } catch (e, stackTrace) {
        _log.w('getSecretRoomEncryptionKey with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await roomApiService.getSecretRoomEncryptionKey(request);
    return httpResp?.toEntity();
  }

  @override
  Future<PaginationPayload<RoomMemberEntity>> getMembersInRoom(GetRoomMembersRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await roomSocketService.getMembersInRoom(request);
        return PaginationPayload(
          data: response.data?.map((e) => e.toEntity()).toList(),
          page: response.page,
          total: response.total,
          totalPages: response.totalPages,
          pageSize: response.pageSize,
        );
      } catch (e, stackTrace) {
        _log.w('getMembersInRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await roomApiService.getMembersInRoom(request);
    return PaginationPayload(
      data: response.data?.map((e) => e.toEntity()).toList(),
      page: response.page,
      total: response.total,
      totalPages: response.totalPages,
      pageSize: response.pageSize,
    );
  }

  /// Get public key of the requested room.
  /// If the requested room doesn't have public key, The value in response will be '{}'
  @override
  Future<RoomEncryptionKeyEntity?> getRoomEncryptionKey(GetRoomEncryptionKeyRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await roomSocketService.getRoomEncryptionKey(request);
        return socketResp?.toEntity();
      } catch (e, stackTrace) {
        _log.w('getRoomEncryptionKey with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await roomApiService.getRoomEncryptionKey(request);
    return httpResp?.toEntity();
  }

  @override
  Future<Either<dynamic, bool>> isCallStillAvailable(String roomId) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await roomSocketService.isCallStillAvailable(roomId);
        return Right(socketResp);
      } catch (e, stackTrace) {
        _log.w('isCallStillAvailable with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      final httpResp = await roomApiService.isCallStillAvailable(roomId);
      return Right(httpResp);
    } catch (e, stackTrace) {
      _log.e('isCallStillAvailable with http error', e, stackTrace);
      return Left(e);
    }
  }

  @override
  Future<Either<dynamic, bool>> notifyCaptureScreenInSecretChat(String roomId) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await roomSocketService.notifyCaptureScreenInSecretChat(roomId);

        if (socketResp != null) {
          return Right(socketResp);
        }
        return const Left('notifyCaptureScreenInSecretChat response is null');
      } catch (e, stackTrace) {
        _log.w('notifyCaptureScreenInSecretChat with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      final httpResp = await roomApiService.notifyCaptureScreenInSecretChat(roomId);
      if (httpResp != null) {
        return Right(httpResp);
      }
      return const Left('notifyCaptureScreenInSecretChat response is null');
    } catch (e, stackTrace) {
      _log.e('notifyCaptureScreenInSecretChat with http error', e, stackTrace);
      return Left(e);
    }
  }

  // ROOMMMEntity
  // RoomEntity
  // RoomSubEntity
  @override
  Future<OpenDirectChatResponse?> openDirectChat(OpenDirectChatRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await roomSocketService.openDirectChat(request);
      } catch (e, stackTrace) {
        _log.w('openDirectChat with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await roomApiService.openDirectChat(request);
  }

  @override
  Future<OpenSystemChatResponse?> openSystemChat() async {
    if (socketCaller.isReadyForCall) {
      try {
        return await roomSocketService.openSystemChat();
      } catch (e, stackTrace) {
        _log.w('openSystemChat with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await roomApiService.openSystemChat();
  }

  @override
  Future<Either<dynamic, void>> openSupportTicket({required OpenSupportTicketRequest request}) async {
    if (socketCaller.isReadyForCall) {
      try {
        await roomSocketService.openSupportTicket(request);
        return const Right(null);
      } catch (e, stackTrace) {
        _log.w('openSupportTicket with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      await roomApiService.openSupportTicket(request);
      return const Right(null);
    } catch (e, stackTrace) {
      _log.e('openSupportTicket with http error', e, stackTrace);
      return Left(e);
    }
  }

  @override
  Future<Either<dynamic, void>> resetCallStatus() async {
    try {
      await roomApiService.resetCallStatus();
      return const Right(null);
    } catch (e) {
      _log.e('resetCallStatus with http error', e);
      return Left(e);
    }
  }

  @override
  Future<Either<dynamic, bool>> setLockMessagePassword(SetLockMessagePasswordRequest req) async {
    if (socketCaller.isReadyForCall) {
      try {
        final res = await roomSocketService.setLockMessagePassword(req);

        if (res != null) {
          return Right(res);
        }
        return const Left('setLockMessagePassword response is null');
      } catch (e, stackTrace) {
        _log.w('setLockMessagePassword with socket error. fallback to http request...', e, stackTrace);
      }
    }

    try {
      final res = await roomApiService.setLockMessagePassword(req);
      if (res != null) {
        return Right(res);
      }
      return const Left('setLockMessagePassword response is null');
    } catch (e, stackTrace) {
      _log.e('setLockMessagePassword with http error', e, stackTrace);
      return Left(e);
    }
  }

  @override
  Future<void> triggerOfflineQueue() async {
    final offlineTaskList = await offlineTaskDb.getAllOfflineTask();

    for (final task in offlineTaskList) {
      if (task.type == 'ROOM_READ') {
        final taskData = json.decode(task.data ?? '');
        // TODO: fix model
        final req = ReadMessageRequest(
          roomId: taskData['roomId'],
          seenMessageAt: DateTime.parse(taskData['seenMessageAt']),
        );
        try {
          await triggerReadMessage(req);
        } catch (e) {
          _log.e('Send read state to server error.', e);
        }
      }
    }
    await offlineTaskDb.deleteOfflineTaskWithType('ROOM_READ');
  }

  @override
  Future<void> triggerReadMessage(ReadMessageRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await roomSocketService.triggerReadMessage(request);
        return;
      } catch (e, stackTrace) {
        _log.w('triggerReadMessage with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await roomApiService.triggerReadMessage(request);
  }

  @override
  Future<void> updateLastTypedAt(UpdateLastTypedAtRequest request) async {
    await roomSocketService.updateLastTypedAt(request);
  }

  @override
  Future<void> shareFile(ShareFileRequest request) async {
    await roomApiService.shareFile(request);
  }

  @override
  Future<bool> checkIsOwner() async {
    if (socketCaller.isReadyForCall) {
      try {
        final res = await roomSocketService.checkIsOwner();
        return res;
      } catch (e, stackTrace) {
        _log.w('checkIsOwner with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final res = await roomApiService.checkIsOwner();
    return res;
  }

  @override
  Future<FindGroupResponse?> findGroup(FindGroupRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await roomSocketService.findGroup(request);
      } catch (e, stackTrace) {
        _log.w('findGroup with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await roomApiService.findGroup(request);
  }

  @override
  Future<List<RoomEntity>?> getAllGroupRoomOwnByMe() async {
    if (socketCaller.isReadyForCall) {
      try {
        final room = await roomSocketService.getAllGroupRoomOwnByMe();
        return room?.map((e) => e.toEntity()).toList();
      } catch (e, stackTrace) {
        _log.w('findGroup with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final room = await roomApiService.getAllGroupRoomOwnByMe();

    return room?.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> leaveGroupWithMeAsAnOwner(LeaveGroupWithMeAsAnOwnerRequest data) async {
    if (socketCaller.isReadyForCall) {
      try {
        await roomSocketService.leaveGroupWithMeAsAnOwner(data);
        return;
      } catch (e, stackTrace) {
        _log.w('leaveGroupWithMeAsAnOwner with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await roomApiService.leaveGroupWithMeAsAnOwner(data);
  }

  @override
  Future<GroupPermissionEntity?> getGroupPermission(String roomId) async {
    return callApiWithFallback(
      socketCaller: socketCaller,
      socketCall: () => roomSocketService.fetchGroupPermissions(roomId),
      httpCall: () => roomApiService.fetchGroupPermissions(roomId),
      methodName: 'getGroupPermission',
    );
  }

  @override
  Future<GroupPermissionEntity> updateGroupPermission(GroupPermissionEntity permission) async {
    return callApiWithFallback(
      socketCaller: socketCaller,
      socketCall: () => roomSocketService.updateGroupPermissions(permission),
      httpCall: () => roomApiService.updateGroupPermissions(permission),
      methodName: 'updateGroupPermission',
    );
  }

  @override
  Future<RichMenuModel?> getOaRichMenu(String officialAccountId) async {
    return callApiWithFallback(
      socketCaller: socketCaller,
      socketCall: () => roomSocketService.fetchOaRichMenu(officialAccountId),
      httpCall: () => roomApiService.fetchOaRichMenu(officialAccountId),
      methodName: 'getOaRichMenu',
    );
  }
}
