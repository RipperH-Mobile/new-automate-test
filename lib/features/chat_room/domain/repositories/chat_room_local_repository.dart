import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_account_from_member_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_direct_chat_response.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

abstract class ChatRoomLocalRepository {
  Future<void> updateAllRoom(List<RoomEntity> rooms);

  Future<void> updateAllRoomWithoutTxn(List<RoomEntity> rooms);

  Future<RoomEntity> putRoom(RoomEntity room, {bool replaceData});

  Future<RoomEntity> putRoomWithoutTxn(RoomEntity room, {bool replaceData});

  Future<void> deleteRoom(String roomId);

  Future<void> deleteRoomWithoutTxn(String roomId);

  Future<void> clearCollection();

  Future<RoomEntity?> saveOpenDirectChatResult(OpenDirectChatResponse data);

  Future<void> clearAllLatestSearch();

  Future<RoomEntity?> getRoom(String roomId);

  RoomEntity? getRoomSync(String roomId);

  Future<List<RoomEntity>?> getRooms(List<String> ids);

  Future<List<RoomEntity>?> getGroupsWithMeAsAnOwner();

  Future<List<RoomEntity>?> getRoomsNotSecretAndNotBookmark(List<String> ids);

  Future<RoomEntity?> getBookmarkRoom();

  Future<List<RoomEntity>?> getRoomLatestSearch({int? limit});

  Future<List<RoomEntity>?> getRoomTypeGroup();

  Future<List<RoomEntity>?> searchRoomTypeGroup(String keyword);

  List<RoomEntity>? getRoomTypeDirectSync();

  Future<int?> putAllRoom(List<RoomEntity> roomList);

  Future<int> putAllRoomSub(List<RoomSubscriptionEntity> roomSubList);

  Future<RoomSubscriptionEntity?> getRoomSubscription(String roomId);

  Future<void> updateRoomSubscription(RoomSubscriptionEntity roomSub);

  Future<void> putOrUpdateRoom(RoomEntity room);

  Future<List<RoomMemberEntity>?> getAllMemberInRoom(String roomId);

  Future<RoomMemberEntity?> getOneMemberInRoom(GetAccountFromMemberRequest params);

  RoomMemberEntity? getOneMemberInRoomSync(GetAccountFromMemberRequest params);

  Future<void> updateMemberInRoom(RoomMemberEntity member);

  Future<void> deleteRoomSubscriptionWithRoomId(String roomId);

  Future<RoomSubscriptionEntity?> putRoomSub(RoomSubscriptionEntity roomSub);

  Future<void> deleteMemberInRoom(String roomId);

  Future<void> updateAllRoomMember(List<RoomMemberEntity> members);

  Future<List<RoomSubscriptionEntity>?> getAllUnreadRoom();

  Future<void> saveAll(List<RoomSubscriptionEntity> params, {bool withTxn = true});

  Future<PaginationPayload<RoomSubscriptionEntity>> getRoomSubCanShowInShare({
    int page = 1,
    int pageSize = 20,
  });

  Future<List<RoomSubscriptionEntity>> getRecentDirectChat({int? limit, String? keyword, int? offset});

  Future<RoomMemberEntity?> getFirstOtherInRoom({required String roomId});

  Future<List<RoomMemberEntity>?> getAllFirstOtherInRoom({required List<String> roomIds});

  Future<List<RoomSubscriptionEntity>> getRoomSubscriptionByChatFolder({
    required String chatFolderId,
    bool? isPinned,
  });

  List<RoomMemberEntity> getAllMembersInRoom(String roomId);

  Future<String?> getDirectRoomIdByOtherIdInRoom(String contactId);

  Future<GroupPermissionEntity?> getGroupPermission(String roomId);

  Future<GroupPermissionEntity> updateGroupPermission(GroupPermissionEntity permission);

  Future<List<GroupPermissionEntity>> updateGroupPermissions(List<GroupPermissionEntity> permissions);

  Stream<GroupPermissionEntity> watchGroupPermission(String roomId);

  Future<List<GroupPermissionEntity>> getGroupPermissionWithIds(List<String> roomIds);
}
