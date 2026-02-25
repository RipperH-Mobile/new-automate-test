import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/responses/update_secret_room_expire_at_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/accept_group_member_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_member_to_chat_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_access_type_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_owner_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_room_name_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/edit_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/end_secret_chat_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_group_waiting_member_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_detail_media_count_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_detail_media_count_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_links_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_response.dart';
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
import 'package:uchat/features/chat_room_detail/data/models/requests/search_in_room_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/set_default_group_avatar_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/set_room_theme_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_hide_message_notification_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_mute_call_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_show_expired_date_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/un_public_menu_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/update_admins_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/update_secret_room_expire_at_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/responses/room_invite_link_response.dart';

class ChatRoomDetailSocketService {
  ChatRoomDetailSocketService({
    required this.socketCaller,
  });

  final SocketCaller socketCaller;

  Future<List<RoomFileCollection>?> fetchRoomPhotoAndVideo(
    RoomPhotoAndVideoRequest request,
  ) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.fetchRoomPhotoAndVideo.socket,
      request.toJson(),
    );

    return socketResp
        .listToResponseV3<RoomFileCollection>(
          (data) => RoomFileCollection.fromMap(data)..roomId = request.roomId,
        )
        ?.toList();
  }

  Future<PaginationPayload<RoomFileCollection>?> fetchRoomFiles(
    FetchRoomFileRequest request,
  ) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.fetchRoomFiles.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse(
      (data) => PaginationPayload<RoomFileCollection>.fromMapV3(
        data,
        listMapper: (files) {
          return files.map((item) => RoomFileCollection.fromMap(item));
        },
      ),
    );
  }

  Future<void> updateAdmins(UpdateAdminsRequest request) async {
    await socketCaller.emitCall(
      BackendPath.updateAdmins.socket,
      request.toJson(),
    );
  }

  Future<void> removeMemberFromChat(RemoveMemberFromChatRequest request) async {
    await socketCaller.emitCall(
      BackendPath.removeMemberFromChat.socket,
      request.toJson(),
    );
  }

  // TODO: improve this function
  /// to get default group avatar from server
  /// return list of default group avatar url
  Future<List<String>?> fetchDefaultGroupAvatar() async {
    // Emit socket call to server to get default group avatar
    final socketResp = await socketCaller.emitCall(
      BackendPath.fetchDefaultGroupAvatar.socket,
      {},
    );

    // Extract the data from SocketResponse
    final socketData = socketResp.data;
    if (socketData is List) {
      return List<String>.from(socketData.whereType<String>());
    } else {
      throw Exception('Unexpected socket response format: ${socketData.runtimeType}');
    }
  }

  Future<void> acceptGroupMemberRequest(
    AcceptGroupMemberRequest request,
  ) async {
    await socketCaller.emitCall(
      BackendPath.acceptGroupMemberRequest.socket,
      request.toJson(),
    );
  }

  Future<void> addMemberToChat(AddMemberToChatRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.inviteMemberToGroup.socket,
      request.toJson(),
    );
  }

  Future<RoomAccessType?> changeGroupAccessType(ChangeGroupAccessTypeRequest request) async {
    final response = await socketCaller.emitCallV3(
      BackendPath.changeGroupAccessType.socket,
      request.toJson(),
    );

    if (response.data != null) {
      final accessTypeString = response.data['data']?['accessType'] as String?;
      if (accessTypeString != null) {
        return RoomAccessType.from(accessTypeString);
      }
    }

    return null;
  }

  Future<void> changeGroupOwner(ChangeGroupOwnerRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.changeGroupOwner.socket,
      request.toJson(),
    );
  }

  Future<void> changeRoomName(ChangeRoomNameRequest request) async {
    await socketCaller.emitCall(
      BackendPath.changeRoomName.socket,
      request.toJson(),
    );
  }

  Future<void> endSecretChat(EndSecretChatRequest request) async {
    await socketCaller.emitCall(
      BackendPath.endSecretChat.socket,
      request.toJson(),
    );
  }

  Future<FindGroupResponse?> findGroup(FindGroupRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.findGroup.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse((data) => FindGroupResponse.fromJson(data));
  }

  Future<List<RoomMemberCollection>?> getGroupMemberRequestList(
    FetchGroupWaitingMemberRequest request,
  ) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.getGroupMemberRequestList.socket,
      request.toJson(),
    );

    return socketResp
        .listToResponse<RoomMemberCollection>(
          (data) => RoomMemberCollection.fromMap(data),
        )
        ?.toList();
  }

  Future<RoomCollection?> getMyChatRoom(GetMemberListRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getMyChatRoom.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data['data']),
    );
  }

  Future<RoomInviteListResponse?> getRoomInviteList() async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.getRoomInviteList.socket,
      {},
    );

    return socketResp.mapToResponse<RoomInviteListResponse>(
      (data) => RoomInviteListResponse.fromJson(data),
    );
  }

  // TODO: create response for this
  Future<List<RoomCollection>?> getRoomTypeGroupAndBeOwner(GetRoomTypeGroupAndBeOwnerRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.getRoomOwnByMe.socket,
      request.toJson(),
    );

    List<RoomCollection> dataList = [];
    final rows = socketResp.data['rows'];

    for (final row in rows) {
      dataList.add(RoomCollection.fromMap(row));
    }

    return dataList;
  }

  Future<RoomCollection?> publishMenu(PublicMenuRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.publishMenu.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<RoomCollection?> unPublishMenu(UnPublicMenuRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.unpublishMenu.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<void> rejectGroupMemberRequest(
    RejectGroupMemberRequest request,
  ) async {
    await socketCaller.emitCall(
      BackendPath.rejectGroupMemberRequest.socket,
      request.toJson(),
    );
  }

  Future<List<MessageCollection>?> searchInRoom(SearchInRoomRequest params) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.searchMessageInRoom.socket,
      params.toJson(),
    );

    return socketResp.listToResponse((e) => MessageCollection.fromMap(e))?.toList();
  }

  Future<void> setDefaultGroupAvatar(SetDefaultGroupAvatarRequest params) async {
    await socketCaller.emitCall(
      BackendPath.setDefaultGroupAvatar.socket,
      params.toJson(),
    );
  }

  Future<RoomSubscriptionCollection?> toggleHideMessageNotification(
    ToggleHideMessageNotificationRequest request,
  ) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.toggleHideMessageNotification.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );
  }

  Future<RoomSubscriptionCollection?> toggleMuteCallNotification(ToggleMuteCallRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.toggleMuteCallNotification.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );
  }

  Future<void> toggleShowExpiredDate(ToggleShowExpiredDateRequest request) async {
    await socketCaller.emitCall(
      BackendPath.toggleShowExpiredDate.socket,
      request.toJson(),
    );
  }

  Future<RoomCollection?> updateMenu(RoomMenuRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.updateMenu.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<UpdateSecretRoomExpireAtResponse?> updateSecretRoomExpiredAt(UpdateSecretRoomExpireAtRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.updateSecretRoomExpiredAt.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse<UpdateSecretRoomExpireAtResponse>(
      (data) => UpdateSecretRoomExpireAtResponse.fromMap(data),
    );
  }

  Future<FetchRoomDetailMediaCountResponse?> fetchRoomDetailMediaCount(FetchRoomDetailMediaCountRequest req) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.fetchRoomDetailMediaCount.socket,
      req.toJson(),
    );
    return socketResp.mapToResponse<FetchRoomDetailMediaCountResponse>(
      (data) => FetchRoomDetailMediaCountResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<RoomDetailMemberAndPendingModel>?> getRoomMemberAndPendingList(
      GetRoomDetailMemberAndPendingRequest req) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getRoomMemberAndPendingList.socket,
      req.toJson(),
    );

    return socketResp.mapToResponse((e) {
      return PaginationPayload<RoomDetailMemberAndPendingModel>.fromMapV3(
        e,
        listMapper: (data) {
          List<RoomDetailMemberAndPendingModel> dataList = [];
          for (final item in data) {
            dataList.add(RoomDetailMemberAndPendingModel.fromJson(
              item,
            ));
          }
          return dataList;
        },
      );
    });
  }

  Future<void> removeRoomDetailWaitingListMember(
    RemovePendingMembersRequest request,
  ) async {
    await socketCaller.emitCallV3(
      BackendPath.removeRoomDetailInvite.socket,
      request.toJson(),
    );
  }

  Future<void> setRoomTheme(
    SetRoomThemeRequest request,
  ) async {
    await socketCaller.emitCallV3(
      BackendPath.setRoomTheme.socket,
      request.toJson(),
    );
  }

  Future<PaginationPayload<RoomLinksResponse>?> getRoomLinks(
    FetchRoomLinksRequest request,
  ) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getRoomLinks.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse((e) {
      return PaginationPayload<RoomLinksResponse>.fromMapV3(
        e,
        listMapper: (data) {
          List<RoomLinksResponse> dataList = [];
          for (final item in data) {
            dataList.add(RoomLinksResponse.fromJson(item));
          }
          return dataList;
        },
      );
    });
  }

  Future<void> addGroupAdmin(AddGroupAdminRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.addGroupAdmin.socket,
      request.toJson(),
    );
  }

  Future<void> editGroupAdmin(EditGroupAdminRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.editGroupAdmin.socket,
      request.toJson(),
    );
  }

  Future<void> removeGroupAdmin(RemoveGroupAdminRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.removeGroupAdmin.socket,
      request.toJson(),
    );
  }

  Future<RoomInviteLinkResponse?> getRoomInviteLink(String roomId) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getRoomInviteLink.socket,
      {'roomId': roomId},
    );

    return socketResp.mapToResponse<RoomInviteLinkResponse>(
      (data) => RoomInviteLinkResponse.fromMap(data),
    );
  }

  Future<RoomInviteLinkResponse?> updateRoomInviteLink(RoomInviteLinkRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.updateRoomInviteLink.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse<RoomInviteLinkResponse>(
      (data) => RoomInviteLinkResponse.fromMap(data),
    );
  }

  Future<RoomInviteLinkResponse?> revokeRoomInviteLink(RevokeRoomInviteLinkRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.revokeRoomInviteLink.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse<RoomInviteLinkResponse>(
      (data) => RoomInviteLinkResponse.fromMap(data),
    );
  }
}
