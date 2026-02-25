import 'package:uchat/api/payloads.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/change_room_photo_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/update_secret_room_expire_at_response.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room_detail/data/data_source/remote/chat_room_detail_api_service.dart';
import 'package:uchat/features/chat_room_detail/data/data_source/remote/chat_room_detail_socket_service.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/accept_group_member_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_member_to_chat_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_access_type_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_owner_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_room_name_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/create_group_chat_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/edit_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/end_secret_chat_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_group_waiting_member_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_detail_media_count_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_detail_media_count_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_links_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_member_list_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_room_detail_waiting_list_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_room_type_group_and_be_owner_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/public_menu_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/reject_group_member_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/remove_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/remove_member_from_chat_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/remove_pending_members_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/revoke_room_invite_link_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_invite_link_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_invite_list_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_links_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_menu_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_photo_and_video_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/set_default_group_avatar_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/set_room_theme_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_hide_message_notification_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_mute_call_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_show_expired_date_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/un_public_menu_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/update_admins_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/update_secret_room_expire_at_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/create_group_chat_response_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';

class ChatRoomDetailRepositoryImpl implements ChatRoomDetailServerRepository {
  final SocketCaller socketCaller;
  final ChatRoomDetailApiService chatRoomDetailApiService;
  final ChatRoomDetailSocketService chatRoomDetailSocketService;

  ChatRoomDetailRepositoryImpl({
    required this.socketCaller,
    required this.chatRoomDetailApiService,
    required this.chatRoomDetailSocketService,
  });

  final _log = useLogger();

  @override
  Future<PaginationPayload<RoomFileEntity>?> fetchRoomFiles(FetchRoomFileRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final result = await chatRoomDetailSocketService.fetchRoomFiles(request);
        if (result != null) {
          return PaginationPayload(
            data: result.data?.map((e) => e.toEntity()),
            total: result.total,
            page: result.page,
            pageSize: result.pageSize,
            totalPages: result.totalPages,
          );
        }
        return null;
      } catch (e, stackTrace) {
        _log.w('fetchRoomFiles with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final result = await chatRoomDetailApiService.fetchRoomFiles(request);
    if (result != null) {
      return PaginationPayload(
        data: result.data?.map((e) => e.toEntity()),
        total: result.total,
        page: result.page,
        pageSize: result.pageSize,
        totalPages: result.totalPages,
      );
    }
    return null;
  }

  @override
  Future<List<RoomFileEntity>?> fetchRoomPhotoAndVideo(RoomPhotoAndVideoRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final result = await chatRoomDetailSocketService.fetchRoomPhotoAndVideo(request);
        return result?.map((e) => e.toEntity()).toList();
      } catch (e, stackTrace) {
        _log.w('fetchRoomPhotoAndVideo with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final result = await chatRoomDetailApiService.fetchRoomPhotoAndVideo(request);
    return result?.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> updateAdmins(UpdateAdminsRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.updateAdmins(request);
        return;
      } catch (e, stackTrace) {
        _log.w('updateAdmins with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.updateAdmins(request);
  }

  @override
  Future<void> removeMemberFromChat(RemoveMemberFromChatRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.removeMemberFromChat(request);
        return;
      } catch (e, stackTrace) {
        _log.w('removeMemberFromChat with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.removeMemberFromChat(request);
  }

  @override
  Future<void> acceptGroupMemberRequest(AcceptGroupMemberRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.acceptGroupMemberRequest(request);
        return;
      } catch (e, stackTrace) {
        _log.w('acceptGroupMemberRequest with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.acceptGroupMemberRequest(request);
  }

  @override
  Future<void> addMemberToChat(AddMemberToChatRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.addMemberToChat(request);
        return;
      } catch (e, stackTrace) {
        _log.w('addMemberToChat with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.addMemberToChat(request);
  }

  @override
  Future<RoomAccessType?> changeGroupAccessType(ChangeGroupAccessTypeRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.changeGroupAccessType(request);
      } catch (e, stackTrace) {
        _log.w('changeGroupAccessType with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.changeGroupAccessType(request);
  }

  @override
  Future<void> changeGroupOwner(ChangeGroupOwnerRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.changeGroupOwner(request);
        return;
      } catch (e, stackTrace) {
        _log.w('changeGroupOwner with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.changeGroupOwner(request);
  }

  @override
  Future<void> changeRoomName(ChangeRoomNameRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.changeRoomName(request);
        return;
      } catch (e, stackTrace) {
        _log.w('changeRoomName with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.changeRoomName(request);
  }

  @override
  Future<void> changeRoomPhoto(ChangeRoomPhotoRequest request) async {
    await chatRoomDetailApiService.changeRoomPhoto(request);
  }

  @override
  Future<CreateGroupChatResponseEntity?> createGroupChat(CreateGroupChatRequest request) async {
    final response = await chatRoomDetailApiService.createGroupChat(request);
    return response?.toEntity();
  }

  @override
  Future<void> endSecretChat(EndSecretChatRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.endSecretChat(request);
      } catch (e, stackTrace) {
        _log.w('endSecretChat with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.endSecretChat(request);
  }

  @override
  Future<List<RoomMemberEntity>?> getGroupMemberRequestList(
    FetchGroupWaitingMemberRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final result = await chatRoomDetailSocketService.getGroupMemberRequestList(request);
        return result?.map((e) => e.toEntity()).toList();
      } catch (e, stackTrace) {
        _log.w('getGroupMemberRequestList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final result = await chatRoomDetailApiService.getGroupMemberRequestList(request);
    return result?.map((e) => e.toEntity()).toList();
  }

  @override
  Future<RoomCollection?> getMyChatRoom(GetMemberListRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.getMyChatRoom(request);
      } catch (e, stackTrace) {
        _log.w('getRoomInviteList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.getMyChatRoom(request);
  }

  @override
  Future<RoomInviteListResponse?> getRoomInviteList() async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.getRoomInviteList();
      } catch (e, stackTrace) {
        _log.w('getRoomInviteList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.getRoomInviteList();
  }

  @override
  Future<List<RoomEntity>?> getRoomTypeGroupAndBeOwner(
    GetRoomTypeGroupAndBeOwnerRequest request,
  ) async {
    final socketResp = await chatRoomDetailSocketService.getRoomTypeGroupAndBeOwner(request);

    if (socketResp != null) {
      final entities = socketResp.map((e) => e.toEntity()).toList();
      return entities;
    } else {
      return null;
    }
  }

  @override
  Future<RoomCollection?> publishMenu(PublicMenuRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.publishMenu(request);
      } catch (e, stackTrace) {
        _log.w('publishMenu with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.publishMenu(request);
  }

  @override
  Future<void> rejectGroupMemberRequest(RejectGroupMemberRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.rejectGroupMemberRequest(request);
        return;
      } catch (e, stackTrace) {
        _log.w('rejectGroupMemberRequest with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.rejectGroupMemberRequest(request);
  }

  @override
  Future<void> setDefaultGroupAvatar(SetDefaultGroupAvatarRequest params) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.setDefaultGroupAvatar(params);
        return;
      } catch (e, stackTrace) {
        _log.w('setDefaultGroupAvatar with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.setDefaultGroupAvatar(params);
  }

  @override
  Future<RoomSubscriptionEntity?> toggleHideMessageNotification(
    ToggleHideMessageNotificationRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final roomSubscription = await chatRoomDetailSocketService.toggleHideMessageNotification(request);
        return roomSubscription?.toEntity();
      } catch (e, stackTrace) {
        _log.w('toggleHideMessageNotification with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final roomSubscription = await chatRoomDetailApiService.toggleHideMessageNotification(request);
    return roomSubscription?.toEntity();
  }

  @override
  Future<bool> toggleMuteCallNotification(ToggleMuteCallRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final roomSubscription = await chatRoomDetailSocketService.toggleMuteCallNotification(request);

        return roomSubscription?.isMutedCall ?? false;
      } catch (e, stackTrace) {
        _log.w('toggleMuteCallNotification with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final roomSubscription = await chatRoomDetailApiService.toggleMuteCallNotification(request);

    return roomSubscription?.isMutedCall ?? false;
  }

  @override
  Future<void> toggleShowExpiredDate(ToggleShowExpiredDateRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.toggleShowExpiredDate(request);
      } catch (e, stackTrace) {
        _log.w('toggleShowExpiredDate with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.toggleShowExpiredDate(request);
  }

  @override
  Future<RoomCollection?> unPublishMenu(UnPublicMenuRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.unPublishMenu(request);
      } catch (e, stackTrace) {
        _log.w('unPublishMenu with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.unPublishMenu(request);
  }

  @override
  Future<RoomCollection?> updateMenu(RoomMenuRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.updateMenu(request);
      } catch (e, stackTrace) {
        _log.w('updateMenu with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.updateMenu(request);
  }

  @override
  Future<UpdateSecretRoomExpireAtResponse?> updateSecretRoomExpiredAt(UpdateSecretRoomExpireAtRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.updateSecretRoomExpiredAt(request);
      } catch (e, stackTrace) {
        _log.w('updateSecretRoomExpiredAt with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.updateSecretRoomExpiredAt(request);
  }

  @override
  Future<FetchRoomDetailMediaCountResponse?> fetchRoomDetailMediaCount(FetchRoomDetailMediaCountRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.fetchRoomDetailMediaCount(request);
      } catch (e, stackTrace) {
        _log.w('fetchRoomDetailMediaCount with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.fetchRoomDetailMediaCount(request);
  }

  @override
  Future<PaginationPayload<RoomDetailMemberAndPendingModel>?> getRoomMemberAndPendingList(
      GetRoomDetailMemberAndPendingRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.getRoomMemberAndPendingList(request);
      } catch (e, stackTrace) {
        _log.w('getRoomDetailWaitingList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.getRoomDetailWaitingList(request);
  }

  @override
  Future<void> removePendingMembers(RemovePendingMembersRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.removeRoomDetailWaitingListMember(request);
        return;
      } catch (e, stackTrace) {
        _log.w('removeRoomDetailInviteList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.removeRoomDetailWaitingListMember(request);
  }

  @override
  Future<void> setRoomTheme(SetRoomThemeRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        await chatRoomDetailSocketService.setRoomTheme(request);
        return;
      } catch (e, stackTrace) {
        _log.w('setRoomTheme with socket error. fallback to http request...', e, stackTrace);
      }
    }

    await chatRoomDetailApiService.setRoomTheme(request);
  }

  @override
  Future<PaginationPayload<RoomLinksResponse>?> fetchRoomLinks(FetchRoomLinksRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.getRoomLinks(request);
      } catch (e, stackTrace) {
        _log.w('fetchRoomLinks with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.getRoomLinks(request);
  }

  @override
  Future<void> addGroupAdmin(AddGroupAdminRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.addGroupAdmin(request);
      } catch (e, stackTrace) {
        _log.w('addGroupAdmin with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.addGroupAdmin(request);
  }

  @override
  Future<void> editGroupAdmin(EditGroupAdminRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.editGroupAdmin(request);
      } catch (e, stackTrace) {
        _log.w('editGroupAdmin with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.editGroupAdmin(request);
  }

  @override
  Future<void> removeGroupAdmin(RemoveGroupAdminRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        return await chatRoomDetailSocketService.removeGroupAdmin(request);
      } catch (e, stackTrace) {
        _log.w('removeGroupAdmin with socket error. fallback to http request...', e, stackTrace);
      }
    }

    return await chatRoomDetailApiService.removeGroupAdmin(request);
  }

  @override
  Future<RoomInviteLinkEntity?> getRoomInviteLink(String roomId) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomDetailSocketService.getRoomInviteLink(roomId);
        return RoomInviteLinkEntity(
          roomId: roomId,
          enable: InviteLinkStatus.from(response?.isActive ?? false),
          inviteLink: response?.inviteLink,
        );
      } catch (e, stackTrace) {
        _log.w('getRoomInviteLink with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await chatRoomDetailApiService.getRoomInviteLink(roomId);
    return RoomInviteLinkEntity(
      roomId: roomId,
      enable: InviteLinkStatus.from(response?.isActive ?? false),
      inviteLink: response?.inviteLink,
    );
  }

  @override
  Future<RoomInviteLinkEntity?> revokeRoomInviteLink(RevokeRoomInviteLinkRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomDetailSocketService.revokeRoomInviteLink(request);
        return RoomInviteLinkEntity(
          roomId: request.roomId,
          enable: InviteLinkStatus.from(response?.isActive ?? false),
          inviteLink: response?.inviteLink,
        );
      } catch (e, stackTrace) {
        _log.w('revokeRoomInviteLink with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await chatRoomDetailApiService.revokeRoomInviteLink(request);
    return RoomInviteLinkEntity(
      roomId: request.roomId,
      enable: InviteLinkStatus.from(response?.isActive ?? false),
      inviteLink: response?.inviteLink,
    );
  }

  @override
  Future<RoomInviteLinkEntity?> updateRoomInviteLink(RoomInviteLinkRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final response = await chatRoomDetailSocketService.updateRoomInviteLink(request);
        return RoomInviteLinkEntity(
          roomId: request.roomId,
          enable: InviteLinkStatus.from(response?.isActive ?? false),
          inviteLink: response?.inviteLink,
        );
      } catch (e, stackTrace) {
        _log.w('updateRoomInviteLink with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final response = await chatRoomDetailApiService.updateRoomInviteLink(request);
    return RoomInviteLinkEntity(
      roomId: request.roomId,
      enable: InviteLinkStatus.from(response?.isActive ?? false),
      inviteLink: response?.inviteLink,
    );
  }
}
