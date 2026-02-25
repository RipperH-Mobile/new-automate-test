import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/entities/services/offline_task_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/create_secret_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/delete_room_with_countdown_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_all_room_last_seen_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/join_group_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/leave_group_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/reject_group_invite_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_chat_category_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_hide_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_mute_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_pin_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/undo_delete_room_with_countdown_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/accept_group_invite_response.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/create_secret_room_response_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/get_all_room_last_seen_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_hide_message_notification_request.dart';
import 'package:uchat/features/chat_room_list/data/data_source/remote/chat_room_list_api_service.dart';
import 'package:uchat/features/chat_room_list/data/data_source/remote/chat_room_list_socket_service.dart';
import 'package:uchat/features/chat_room_list/data/models/join_group_response.dart';
import 'package:uchat/features/chat_room_list/data/models/read_all_request.dart';
import 'package:uchat/features/chat_room_list/domain/entities/invite_room_entity.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';

class ChatRoomListServerRepositoryImpl implements ChatRoomListServerRepository {
  ChatRoomListServerRepositoryImpl({
    required this.socketCaller,
    required this.chatRoomListApiService,
    required this.chatRoomListSocketService,
    required this.roomSubLocalRepository,
    required this.chatRoomLocalRepository,
    required this.roomDb,
    required this.configDb,
    required this.roomSubscriptionDb,
    required this.roomMemberDb,
    required this.messageDb,
    required this.roomFileDb,
    required this.offlineTaskDb,
  });

  final SocketCaller socketCaller;
  final ChatRoomListApiService chatRoomListApiService;
  final ChatRoomListSocketService chatRoomListSocketService;
  final RoomDb roomDb;
  final ConfigDb configDb;
  final RoomSubscriptionDb roomSubscriptionDb;
  final RoomMemberDb roomMemberDb;
  final MessageDb messageDb;
  final RoomFileDb roomFileDb;
  final OfflineTaskDb offlineTaskDb;
  final RoomSubLocalRepository roomSubLocalRepository;
  final ChatRoomLocalRepository chatRoomLocalRepository;

  final _log = useLogger();

  @override
  Future<void> acceptRoom(AcceptGroupInviteRequest request) async {
    AcceptGroupInviteResponse? resp;
    if (socketCaller.isReadyForCall) {
      try {
        resp = await chatRoomListSocketService.acceptRoom(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('acceptRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }
    resp ??= await chatRoomListApiService.acceptRoom(request);
    if (resp?.room case final resultRoom?) {
      await chatRoomLocalRepository.putRoom(resultRoom.toEntity());
    }
    if (resp?.roomSub case final resultRoomSub?) {
      await roomSubLocalRepository.putRoomSubscription(resultRoomSub.toEntity());
    }
  }

  @override
  Future<CreateSecretRoomResponseEntity?> createSecretRoom(CreateSecretRoomRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.createSecretRoom(request);
        return response?.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('createSecretRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }
    final response = await chatRoomListApiService.createSecretRoom(request);
    return response?.toEntity();
  }

  @override
  Future<RoomEntity?> fetchChatRoom(String roomId) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.fetchChatRoom(roomId);
        return response?.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('fetchChatRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }
    final response = await chatRoomListApiService.fetchChatRoom(roomId);
    return response?.toEntity();
  }

  /// to get default group avatar from server
  /// return list of default group avatar url
  @override
  Future<List<String>> fetchDefaultGroupAvatar() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await chatRoomListSocketService.fetchDefaultGroupAvatar();

        if (socketResp != null) {
          return List<String>.from(socketResp.whereType<String>());
        }
      } catch (e, stackTrace) {
        _log.w('fetchDefaultGroupAvatar with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await chatRoomListApiService.fetchDefaultGroupAvatar();
    if (httpResp != null) {
      return List<String>.from(httpResp.whereType<String>());
    }

    return [];
  }

  @override
  Future<JoinGroupResponse?> joinGroup(JoinGroupRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.joinGroup(request);
        return response;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('joinGroup with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await chatRoomListApiService.joinGroup(request);
    return response;
  }

  @override
  Future<RoomEntity?> leaveGroup(LeaveGroupRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.leaveGroup(request);
        return response?.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('leaveGroup with socket error. fallback to http request...', e, stackTrace);
      }
    }
    final response = await chatRoomListApiService.leaveGroup(request);
    return response?.toEntity();
  }

  @override
  Future<void> rejectRoom(RejectGroupInviteRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomListSocketService.rejectRoom(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('rejectRoomInvite with socket error. fallback to http request...', e, stackTrace);
      }
    }
    return await chatRoomListApiService.rejectRoom(request);
  }

  // TODO: improve
  @override
  Future<RoomSubscriptionEntity?> toggleHideRoom(ToggleHideRoomRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.toggleHideRoom(request);
        return response?.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('toggleHideRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }
    final response = await chatRoomListApiService.toggleHideRoom(request);
    return response?.toEntity();
  }

  @override
  Future<RoomSubscriptionEntity?> togglePinRoom(TogglePinRoomRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.togglePinRoom(request);
        return response?.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('togglePinRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }
    final response = await chatRoomListApiService.togglePinRoom(request);
    return response?.toEntity();
  }

  @override
  Future<void> deleteRoom(String roomId) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomListSocketService.deleteRoom(roomId);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('deleteRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomListApiService.deleteRoom(roomId);
  }

  @override
  Future<List<GetAllRoomLastSeenEntity>?> getAllRoomLastSeen(GetAllRoomLastSeenRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.getAllRoomLastSeen(request);
        return response?.map((item) => item.toEntity()).toList();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('getAllRoomLastSeen with socket error. fallback to http request...', e, stackTrace);
      }
    }
    final response = await chatRoomListApiService.getAllRoomLastSeen(request);
    return response?.map((item) => item.toEntity()).toList();
  }

  @override
  Future<RoomSubscriptionEntity?> toggleMutedRoom(ToggleMuteRoomRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.toggleMutedRoom(request);
        return response?.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('toggleMutedRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }
    final response = await chatRoomListApiService.toggleMutedRoom(request);
    return response?.toEntity();
  }

  @override
  Future<void> readAllRoom(ReadAllRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomListSocketService.handleReadAll(request);
      } on ApiException catch (e, s) {
        _log.w('readAllRoom ApiException with socket error. fallback to http request...', e, s);
      } catch (e, stackTrace) {
        _log.w('readAllRoom with socket error. fallback to http request...', e, stackTrace);
      }
    }
    return await chatRoomListApiService.handleReadAll(request);
  }

  @override
  Future<bool> toggleChatCategory(ToggleChatCategoryRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await chatRoomListSocketService.toggleChatCategory(request);

        return socketResp?.accountSettings?.chat?.showCategory ?? false;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('toggleChatCategory with socket error. fallback to http request...', e, stackTrace);
      }
    }
    final httpResp = await chatRoomListApiService.toggleChatCategory(request);
    return httpResp?.accountSettings?.chat?.showCategory ?? false;
  }

  @override
  Future<void> deleteRoomWithCountdown(DeleteRoomWithCountdownRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomListSocketService.deleteRoomWithCountdown(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('deleteRoomWithCountdown with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomListApiService.deleteRoomWithCountdown(request);
  }

  @override
  Future<void> undoDeleteRoomWithCountdown(UndoDeleteRoomWithCountdownRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomListSocketService.undoDeleteRoomWithCountdown(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('undoDeleteRoomWithCountdown with socket error. fallback to http request...', e, stackTrace);
      }
    }
    return await chatRoomListApiService.undoDeleteRoomWithCountdown(request);
  }

  @override
  Future<RoomSubscriptionEntity?> toggleHideMessageNotification(ToggleHideMessageNotificationRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.toggleHideMessageNotification(request);
        return response?.toEntity();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('toggleHideMessageNotification with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await chatRoomListApiService.toggleHideMessageNotification(request);
    return response?.toEntity();
  }

  @override
  Future<InviteRoomEntity?> verifyInviteLink(String inviteLinkToken) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomListSocketService.verifyInviteLink(inviteLinkToken);
        return response;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('verifyInviteLink with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await chatRoomListApiService.verifyInviteLink(inviteLinkToken);
    return response;
  }
}
