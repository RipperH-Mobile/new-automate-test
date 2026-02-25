import 'package:dio/dio.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:uchat/api/backend_path.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/change_room_photo_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/update_secret_room_expire_at_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/models/room_waiting_list_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/accept_group_member_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_group_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/add_member_to_chat_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_access_type_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_owner_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_room_name_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/create_group_chat_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/create_group_chat_response_model.dart';
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
import 'package:uchat/widgets/loading/loading.dart';

class ChatRoomDetailApiService {
  final HttpCaller httpCaller;

  ChatRoomDetailApiService({
    required this.httpCaller,
  });

  Future<List<RoomFileCollection>?> fetchRoomPhotoAndVideo(
    RoomPhotoAndVideoRequest request,
  ) async {
    final httpResp = await httpCaller.get(
      BackendPath.fetchRoomPhotoAndVideo.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );

    return httpResp
        .listToResponseV3<RoomFileCollection>(
          (data) => RoomFileCollection.fromMap(data)..roomId = request.roomId,
        )
        ?.toList();
  }

  Future<PaginationPayload<RoomFileCollection>?> fetchRoomFiles(
    FetchRoomFileRequest request,
  ) async {
    final httpResp = await httpCaller.get(
      BackendPath.fetchRoomFiles.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );

    return httpResp.mapToResponse(
      (data) => PaginationPayload<RoomFileCollection>.fromMapV3(
        data,
        listMapper: (files) {
          return files.map((item) => RoomFileCollection.fromMap(item));
        },
      ),
    );
  }

  Future<void> updateAdmins(UpdateAdminsRequest request) async {
    await httpCaller.post(
      BackendPath.updateAdmins.http,
      data: request.toJson(),
    );
  }

  Future<void> removeMemberFromChat(RemoveMemberFromChatRequest request) async {
    await httpCaller.post(
      BackendPath.removeMemberFromChat.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  Future<void> acceptGroupMemberRequest(
    AcceptGroupMemberRequest request,
  ) async {
    await httpCaller.post(
      BackendPath.acceptGroupMemberRequest.http,
      data: request.toJson(),
    );
  }

  Future<void> addMemberToChat(AddMemberToChatRequest request) async {
    await httpCaller.post(
      BackendPath.inviteMemberToGroup.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  Future<RoomAccessType?> changeGroupAccessType(ChangeGroupAccessTypeRequest request) async {
    final response = await httpCaller.post(
      BackendPath.changeGroupAccessType.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
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
    await httpCaller.post(
      BackendPath.changeGroupOwner.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  Future<void> changeRoomName(ChangeRoomNameRequest request) async {
    await httpCaller.post(
      BackendPath.changeRoomName.http,
      data: request.toJson(),
    );
  }

  // TODO: move uchat loading to UI
  Future<Map<String, dynamic>> changeRoomPhoto(
    ChangeRoomPhotoRequest request,
  ) async {
    FormData data = await request.toFormData();

    final httpResp = await httpCaller.post(
      BackendPath.changeRoomPhoto.http.replaceAll(
        ':roomId',
        request.roomId,
      ),
      data: data,
      onSendProgress: (count, total) {
        if (count != total) {
          UChatLoading.showProgress(count / total);
        } else {
          UChatLoading.show(status: 'Processing...'.tr);
        }
      },
    );

    return httpResp.data;
  }

  Future<CreateGroupChatResponseModel?> createGroupChat(CreateGroupChatRequest request) async {
    final data = await request.toFormData();

    final httpResp = await httpCaller.post(
      BackendPath.createGroupChat.http,
      options: Options(headers: {
        'content-type': 'multipart/form-data',
      }),
      data: data,
    );

    return httpResp.mapToResponse(
      (data) => CreateGroupChatResponseModel.fromMap(data),
    );
  }

  Future<void> endSecretChat(EndSecretChatRequest request) async {
    await httpCaller.delete(
      BackendPath.endSecretChat.http.replaceAll(':roomId', request.roomId),
    );
  }

  Future<FindGroupResponse?> findGroup(FindGroupRequest request) async {
    final response = await httpCaller.post(
      BackendPath.findGroup.http,
      data: request.toJson(),
    );

    return response.mapToResponse((data) => FindGroupResponse.fromJson(data));
  }

  Future<List<RoomMemberCollection>?> getGroupMemberRequestList(
    FetchGroupWaitingMemberRequest request,
  ) async {
    final httpResp = await httpCaller.post(
      BackendPath.getGroupMemberRequestList.http,
      data: request.toJson(),
    );

    return httpResp
        .listToResponse<RoomMemberCollection>(
          (data) => RoomMemberCollection.fromMap(data),
        )
        ?.toList();
  }

  Future<RoomCollection?> getMyChatRoom(GetMemberListRequest request) async {
    final httpResp = await httpCaller.get(
      BackendPath.getMyChatRoom.http.replaceAll(':roomId', request.roomId),
    );

    return httpResp.mapToResponse(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<RoomInviteListResponse?> getRoomInviteList() async {
    final httpResp = await httpCaller.post(
      BackendPath.getRoomInviteList.http,
    );

    return httpResp.mapToResponseV3<RoomInviteListResponse>(
      (data) => RoomInviteListResponse.fromJson(data),
    );
  }

  Future<RoomCollection?> publishMenu(PublicMenuRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.publishMenu.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<RoomCollection?> unPublishMenu(UnPublicMenuRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.unpublishMenu.socket,
      data: request.toJson(),
    );

    return httpResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<void> rejectGroupMemberRequest(
    RejectGroupMemberRequest request,
  ) async {
    await httpCaller.post(
      BackendPath.rejectGroupMemberRequest.http,
      data: request.toJson(),
    );
  }

  Future<List<MessageCollection>?> searchInRoom(SearchInRoomRequest request) async {
    final httpResp = await httpCaller.get(
      BackendPath.searchMessageInRoom.http.replaceAll(':roomId', request.roomId),
      queryParameters: {
        'keyword': request.keyword,
      },
    );

    return httpResp.listToResponse((e) => MessageCollection.fromMap(e))?.toList();
  }

  Future<void> setDefaultGroupAvatar(SetDefaultGroupAvatarRequest request) async {
    await httpCaller.post(
      BackendPath.setDefaultGroupAvatar.http,
      data: request.toJson(),
    );
  }

  Future<RoomSubscriptionCollection?> toggleHideMessageNotification(
    ToggleHideMessageNotificationRequest request,
  ) async {
    final httpResp = await httpCaller.post(
      BackendPath.toggleHideMessageNotification.socket,
      data: request.toJson(),
    );

    return httpResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );
  }

  Future<RoomSubscriptionCollection?> toggleMuteCallNotification(ToggleMuteCallRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.toggleMuteCallNotification.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );
  }

  Future<void> toggleShowExpiredDate(ToggleShowExpiredDateRequest request) async {
    await httpCaller.post(
      BackendPath.toggleShowExpiredDate.http,
      data: request.toJson(),
    );
  }

  Future<RoomCollection?> updateMenu(RoomMenuRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.updateMenu.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<UpdateSecretRoomExpireAtResponse?> updateSecretRoomExpiredAt(UpdateSecretRoomExpireAtRequest request) async {
    final httpResp = await httpCaller.get(
      BackendPath.updateSecretRoomExpiredAt.http.replaceAll(':roomId', request.roomId),
    );

    return httpResp.mapToResponse<UpdateSecretRoomExpireAtResponse>(
      (data) => UpdateSecretRoomExpireAtResponse.fromMap(data),
    );
  }

  Future<FetchRoomDetailMediaCountResponse?> fetchRoomDetailMediaCount(FetchRoomDetailMediaCountRequest req) async {
    final httpResp = await httpCaller.get(
      BackendPath.fetchRoomDetailMediaCount.http.replaceAll(':roomId', req.roomId),
      data: req.toJson(),
    );

    return httpResp.mapToResponse<FetchRoomDetailMediaCountResponse>(
      (data) => FetchRoomDetailMediaCountResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<RoomDetailMemberAndPendingModel>?> getRoomDetailWaitingList(
      GetRoomDetailMemberAndPendingRequest req) async {
    final httpResp = await httpCaller.get(
      BackendPath.getRoomMemberAndPendingList.http.replaceAll(':roomId', req.roomId),
      data: req.toJson(),
    );

    // return httpResp.mapToResponse<FetchRoomDetailMediaCountResponse>(
    //   (data) => FetchRoomDetailMediaCountResponse.fromMap(data),
    // );
    return httpResp.mapToResponse((e) {
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

  Future<void> removeRoomDetailWaitingListMember(RemovePendingMembersRequest request) async {
    await httpCaller.post(
      BackendPath.removeRoomDetailInvite.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  Future<PaginationPayload<RoomLinksResponse>?> getRoomLinks(
    FetchRoomLinksRequest request,
  ) async {
    final httpResp = await httpCaller.post(
      BackendPath.getRoomLinks.http.replaceAll(':roomId', request.roomId),
      data: request.toMap(),
    );

    return httpResp.mapToResponse((e) {
      return PaginationPayload<RoomLinksResponse>.fromMapV3(
        e,
        listMapper: (data) {
          List<RoomLinksResponse> dataList = [];
          for (final item in data) {
            dataList.add(RoomLinksResponse.fromJson(
              item,
            ));
          }
          return dataList;
        },
      );
    });
  }

  Future<void> setRoomTheme(SetRoomThemeRequest request) async {
    await httpCaller.put(
      BackendPath.setRoomTheme.http,
      data: request.toJson(),
    );
  }

  Future<void> addGroupAdmin(AddGroupAdminRequest request) async {
    await httpCaller.post(
      BackendPath.addGroupAdmin.http.replaceAll(':roomId', request.roomId),
      data: request.toJsonWithOutRoomId(),
    );
  }

  Future<void> editGroupAdmin(EditGroupAdminRequest request) async {
    await httpCaller.put(
      BackendPath.editGroupAdmin.http.replaceAll(':roomId', request.roomId).replaceAll(':accountId', request.accountId),
      data: request.toJsonWithOutRoomId(),
    );
  }

  Future<void> removeGroupAdmin(RemoveGroupAdminRequest request) async {
    await httpCaller.delete(
      BackendPath.removeGroupAdmin.http
          .replaceAll(':roomId', request.roomId)
          .replaceAll(':accountId', request.accountId),
      data: {},
    );
  }

  Future<RoomInviteLinkResponse?> getRoomInviteLink(String roomId) async {
    final httpResp = await httpCaller.get(
      BackendPath.getRoomInviteLink.http.replaceAll(':roomId', roomId),
    );

    return httpResp.mapToResponse<RoomInviteLinkResponse>(
      (data) => RoomInviteLinkResponse.fromMap(data),
    );
  }

  Future<RoomInviteLinkResponse?> updateRoomInviteLink(RoomInviteLinkRequest request) async {
    final roomId = request.roomId;
    final httpResp = await httpCaller.put(
      BackendPath.updateRoomInviteLink.http.replaceAll(':roomId', roomId),
      data: request.toMap(),
    );

    return httpResp.mapToResponse<RoomInviteLinkResponse>(
      (data) => RoomInviteLinkResponse.fromMap(data),
    );
  }

  Future<RoomInviteLinkResponse?> revokeRoomInviteLink(RevokeRoomInviteLinkRequest request) async {
    final roomId = request.roomId;
    final httpResp = await httpCaller.post(
      BackendPath.revokeRoomInviteLink.http.replaceAll(':roomId', roomId),
      data: request.toMap(),
    );

    return httpResp.mapToResponse<RoomInviteLinkResponse>(
      (data) => RoomInviteLinkResponse.fromMap(data),
    );
  }
}
