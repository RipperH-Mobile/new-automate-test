import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/change_room_photo_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/update_secret_room_expire_at_response.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
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

abstract class ChatRoomDetailServerRepository {
  Future<List<RoomFileEntity>?> fetchRoomPhotoAndVideo(RoomPhotoAndVideoRequest request);

  Future<PaginationPayload<RoomFileEntity>?> fetchRoomFiles(FetchRoomFileRequest request);

  Future<void> removeMemberFromChat(RemoveMemberFromChatRequest request);

  Future<void> updateAdmins(UpdateAdminsRequest request);

  Future<void> acceptGroupMemberRequest(AcceptGroupMemberRequest request);

  Future<void> addMemberToChat(AddMemberToChatRequest request);

  Future<RoomAccessType?> changeGroupAccessType(ChangeGroupAccessTypeRequest request);

  Future<void> changeGroupOwner(ChangeGroupOwnerRequest request);

  Future<void> changeRoomName(ChangeRoomNameRequest request);

  Future<void> changeRoomPhoto(ChangeRoomPhotoRequest request);

  Future<CreateGroupChatResponseEntity?> createGroupChat(CreateGroupChatRequest request);

  Future<void> endSecretChat(EndSecretChatRequest request);

  Future<List<RoomMemberEntity>?> getGroupMemberRequestList(FetchGroupWaitingMemberRequest request);

  // TODO: user entity
  Future<RoomCollection?> getMyChatRoom(GetMemberListRequest request);

  Future<RoomInviteListResponse?> getRoomInviteList();

  Future<List<RoomEntity>?> getRoomTypeGroupAndBeOwner(GetRoomTypeGroupAndBeOwnerRequest request);

  Future<void> rejectGroupMemberRequest(RejectGroupMemberRequest request);

  Future<RoomCollection?> updateMenu(RoomMenuRequest request);

  Future<RoomCollection?> publishMenu(PublicMenuRequest request);

  Future<RoomCollection?> unPublishMenu(UnPublicMenuRequest request);

  Future<void> setDefaultGroupAvatar(SetDefaultGroupAvatarRequest params);

  Future<UpdateSecretRoomExpireAtResponse?> updateSecretRoomExpiredAt(UpdateSecretRoomExpireAtRequest request);

  Future<RoomSubscriptionEntity?> toggleHideMessageNotification(
    ToggleHideMessageNotificationRequest request,
  );

  Future<bool> toggleMuteCallNotification(ToggleMuteCallRequest request);

  Future<void> toggleShowExpiredDate(ToggleShowExpiredDateRequest request);

  Future<FetchRoomDetailMediaCountResponse?> fetchRoomDetailMediaCount(FetchRoomDetailMediaCountRequest request);

  Future<PaginationPayload<RoomDetailMemberAndPendingModel>?> getRoomMemberAndPendingList(
    GetRoomDetailMemberAndPendingRequest request,
  );

  Future<void> removePendingMembers(RemovePendingMembersRequest request);

  Future<void> setRoomTheme(SetRoomThemeRequest request);

  Future<PaginationPayload<RoomLinksResponse>?> fetchRoomLinks(FetchRoomLinksRequest request);

  Future<void> addGroupAdmin(AddGroupAdminRequest request);

  Future<void> editGroupAdmin(EditGroupAdminRequest request);

  Future<void> removeGroupAdmin(RemoveGroupAdminRequest request);

  Future<RoomInviteLinkEntity?> getRoomInviteLink(String roomId);

  Future<RoomInviteLinkEntity?> updateRoomInviteLink(RoomInviteLinkRequest request);

  Future<RoomInviteLinkEntity?> revokeRoomInviteLink(RevokeRoomInviteLinkRequest request);
}
