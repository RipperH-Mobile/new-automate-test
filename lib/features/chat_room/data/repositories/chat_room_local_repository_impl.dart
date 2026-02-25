import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/group_permission_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/group_permission_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_member_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_subscription_mapper_extension.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_direct_chat_response.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/params/fetch_room_member_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_room_member_use_case.dart';

import '../models/responses/get_account_from_member_response.dart';

class ChatRoomLocalRepositoryImpl implements ChatRoomLocalRepository {
  ChatRoomLocalRepositoryImpl({
    required this.roomDb,
    required this.roomSubscriptionDb,
    required this.groupPermissionDb,
  });

  final RoomDb roomDb;
  final RoomSubscriptionDb roomSubscriptionDb;
  final GroupPermissionDb groupPermissionDb;

  final roomMemberDb = GetIt.I<RoomMemberDb>();

  @override
  Future<void> updateAllRoom(List<RoomEntity> rooms) async {
    await roomDb.updateAllRoom(rooms.toCollections());
  }

  @override
  Future<void> updateAllRoomWithoutTxn(List<RoomEntity> rooms) async {
    await roomDb.updateAllRoomWithoutTxn(rooms.toCollections());
  }

  /// Set [replaceData] to true if you want to replace some value with null.
  /// If [replaceData] is false all null properties in [room] will be ignored and local db
  /// data will be updated with non null properties from [room] only.
  @override
  Future<RoomEntity> putRoom(
    RoomEntity room, {
    bool replaceData = false,
  }) async {
    await roomDb.putRoom(room.toCollection(), replaceData: replaceData);

    return room;
  }

  @override
  Future<RoomEntity> putRoomWithoutTxn(
    RoomEntity room, {
    bool replaceData = false,
  }) async {
    await roomDb.putRoomWithoutTxn(room.toCollection(), replaceData: replaceData);

    return room;
  }

  @override
  Future<void> deleteRoom(String roomId) async {
    await roomDb.deleteRoom(roomId);
  }

  @override
  Future<void> deleteRoomWithoutTxn(String roomId) async {
    await roomDb.deleteRoomWithoutTxn(roomId);
  }

  @override
  Future<void> clearCollection() async {
    await roomDb.clearCollection();
  }

  @override
  Future<RoomEntity?> saveOpenDirectChatResult(OpenDirectChatResponse data) async {
    await roomDb.putOrUpdateRoom(RoomCollection.fromEntity(data.room!));
    await roomSubscriptionDb.putRoomSubscription(RoomSubscriptionCollection.fromEntity(data.roomSub!));
    final room = await roomDb.getRoom(data.room!.id);
    await GetIt.I<FetchRoomMemberUseCase>().call(FetchRoomMemberParams(roomId: data.room!.id));

    return room?.toEntity();
  }

  @override
  Future<void> clearAllLatestSearch() async {
    await roomDb.clearAllLatestSearch();
  }

  @override
  Future<RoomEntity?> getRoom(String roomId) async {
    final room = await roomDb.getRoom(roomId);
    return room?.toEntity();
  }

  @override
  RoomEntity? getRoomSync(String roomId) {
    final room = roomDb.getRoomSync(roomId);

    return room?.toEntity();
  }

  @override
  Future<List<RoomEntity>?> getRooms(List<String> ids) async {
    final rooms = await roomDb.getRooms(ids);

    return rooms?.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RoomEntity>?> getGroupsWithMeAsAnOwner() async {
    final groups = await roomDb.getGroupsWithMeAsAnOwner();

    return groups?.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RoomEntity>?> getRoomsNotSecretAndNotBookmark(List<String> ids) async {
    final rooms = await roomDb.getRoomsNotSecretAndNotBookmark(ids);

    if (rooms == null) return null;
    List<RoomEntity> roomsEntity = rooms.map((element) => element.toEntity()).toList();

    return roomsEntity;
  }

  @override
  Future<RoomEntity?> getBookmarkRoom() async {
    final room = await roomDb.getBookmarkRoom();

    if (room == null) return null;

    return room.toEntity();
  }

  @override
  Future<List<RoomEntity>?> getRoomLatestSearch({int? limit}) async {
    final rooms = await roomDb.getRoomLatestSearch(limit: limit);

    if (rooms == null) return null;
    List<RoomEntity> roomsEntity = rooms.map((element) => element.toEntity()).toList();

    return roomsEntity;
  }

  @override
  List<RoomEntity>? getRoomTypeDirectSync() {
    final rooms = roomDb.getRoomTypeDirectSync();

    if (rooms == null) return null;
    List<RoomEntity> roomsEntity = rooms.map((element) => element.toEntity()).toList();

    return roomsEntity;
  }

  @override
  Future<List<RoomEntity>?> getRoomTypeGroup() async {
    final rooms = await roomDb.getRoomTypeGroup();

    if (rooms == null) return null;
    List<RoomEntity> roomsEntity = rooms.map((element) => element.toEntity()).toList();

    return roomsEntity;
  }

  @override
  Future<List<RoomEntity>?> searchRoomTypeGroup(String keyword) async {
    final rooms = await roomDb.searchRoomTypeGroup(keyword);

    if (rooms == null) return null;
    List<RoomEntity> roomsEntity = rooms.map((element) => element.toEntity()).toList();

    return roomsEntity;
  }

  @override
  Future<int?> putAllRoom(List<RoomEntity> roomList) async {
    final addCount = await roomDb.putAllRoom(roomList.toCollections());
    if (addCount != null) return addCount;
    return null;
  }

  @override
  Future<int> putAllRoomSub(List<RoomSubscriptionEntity> roomSubList) async {
    final addCount = await roomSubscriptionDb.putAllRoomSub(roomSubList.toCollections());

    return addCount;
  }

  // @override
  // Future<RoomSubscriptionEntity?> putRoomSub(RoomSubscriptionEntity roomSub) async {
  //   final roomSub =  await roomSubscriptionDb.putRoomSubscription(roomSub);
  //   return roomSub;
  // }

  @override
  Future<RoomSubscriptionEntity?> getRoomSubscription(String roomId) async {
    final collection = await roomSubscriptionDb.getRoomSubscriptionWithRoomId(roomId);
    return collection?.toEntity();
  }

  @override
  Future<void> putOrUpdateRoom(RoomEntity room) async {
    roomDb.putOrUpdateRoom(room.toCollection());
  }

  @override
  Future<List<RoomMemberEntity>?> getAllMemberInRoom(String roomId) async {
    final collection = await roomMemberDb.getAllMemberInRoom(roomId);
    if (collection == null) return null;
    List<RoomMemberEntity> members = collection.map((e) => e.toEntity()).toList();
    return members;
  }

  @override
  Future<RoomMemberEntity?> getOneMemberInRoom(GetAccountFromMemberRequest params) async {
    final roomMember = await roomMemberDb.getOneMemberInRoom(params.roomId, params.accountId);
    return roomMember?.toEntity();
  }

  @override
  RoomMemberEntity? getOneMemberInRoomSync(GetAccountFromMemberRequest params) {
    final collection = roomMemberDb.getOneMemberInRoomSync(params.roomId, params.accountId);
    return collection?.toEntity();
  }

  @override
  Future<void> updateMemberInRoom(RoomMemberEntity member) async {
    return await roomMemberDb.putRoomMember(member.toCollection());
  }

  @override
  Future<void> updateRoomSubscription(RoomSubscriptionEntity roomSub) async {
    await roomSubscriptionDb.putRoomSubscription(roomSub.toCollection());
  }

  @override
  Future<void> deleteRoomSubscriptionWithRoomId(String roomId) async {
    await roomSubscriptionDb.deleteRoomSubWithRoomId(roomId);
  }

  @override
  Future<void> deleteMemberInRoom(String roomId) async {
    await roomMemberDb.deleteMemberInRoom(roomId);
  }

  @override
  Future<void> updateAllRoomMember(List<RoomMemberEntity> members) async {
    await roomMemberDb.updateAllRoomMember(members.toCollections());
  }

  @override
  Future<PaginationPayload<RoomSubscriptionEntity>> getRoomSubCanShowInShare({
    int page = 1,
    int pageSize = 20,
  }) async {
    final roomSubList = await roomSubscriptionDb.getRoomCanShowInShare(page: page, pageSize: pageSize);
    final total = await roomSubscriptionDb.getRoomCanShowInShareCount();

    return PaginationPayload<RoomSubscriptionEntity>(
      total: total,
      totalPages: (total / pageSize).ceil(),
      page: page,
      pageSize: pageSize,
      data: roomSubList.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  Future<List<RoomSubscriptionEntity>> getRecentDirectChat({int? limit, String? keyword, int? offset}) async {
    final result = await roomSubscriptionDb.getRecentDirectChat(limit: limit, keyword: keyword, offset: offset);

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RoomSubscriptionEntity>?> getAllUnreadRoom() async {
    final temp = await roomSubscriptionDb.getAllUnreadRoom();
    return temp?.toEntities();
  }

  @override
  Future<RoomMemberEntity?> getFirstOtherInRoom({required String roomId}) async {
    final temp = await roomMemberDb.getFirstOtherInRoom(roomId);
    return temp?.toEntity();
  }

  @override
  Future<List<RoomMemberEntity>?> getAllFirstOtherInRoom({required List<String> roomIds}) async {
    final temp = await roomMemberDb.getAllFirstOtherInRoom(roomIds);
    return temp?.toEntities();
  }

  @override
  Future<void> saveAll(List<RoomSubscriptionEntity> params, {bool withTxn = true}) async {
    if (withTxn) {
      return await roomSubscriptionDb.updateAllRoomSubscription(params.toCollections());
    }

    return await roomSubscriptionDb.updateAllRoomSubscriptionWithoutTxn(params.toCollections());
  }

  // TODO: Change return from collection to entity, RoomSubscriptionCollection to RoomSubscriptionEntity
  @override
  Future<List<RoomSubscriptionEntity>> getRoomSubscriptionByChatFolder({
    required String chatFolderId,
    bool? isPinned,
  }) async {
    final collections = await roomSubscriptionDb.getAllRoomSubByChatFolderId(
      chatFolderId: chatFolderId,
      isPinned: isPinned,
    );
    return collections.map((e) => e.toEntity()).toList();
  }

  @override
  List<RoomMemberEntity> getAllMembersInRoom(String roomId) {
    final members = roomMemberDb.getAllMemberInRoomSync(roomId);
    return members?.map((e) => e.toEntity()).toList() ?? [];
  }

  @override
  Future<String?> getDirectRoomIdByOtherIdInRoom(String contactId) async {
    return await roomMemberDb.getDirectRoomIdByOtherIdInRoom(contactId);
  }

  @override
  Future<RoomSubscriptionEntity?> putRoomSub(RoomSubscriptionEntity roomSub) {
    return roomSubscriptionDb.putRoomSubscription(roomSub.toCollection()).then((value) => value?.toEntity());
  }

  @override
  Future<GroupPermissionEntity?> getGroupPermission(String roomId) async {
    final permission = await groupPermissionDb.getByRoomId(roomId);
    return permission?.toEntity();
  }

  @override
  Future<GroupPermissionEntity> updateGroupPermission(GroupPermissionEntity permission) async {
    await groupPermissionDb.save(permission.toCollection());
    return permission;
  }

  @override
  Future<List<GroupPermissionEntity>> updateGroupPermissions(List<GroupPermissionEntity> permissions) async {
    await groupPermissionDb.saveAll(permissions.toCollections());
    return permissions;
  }

  @override
  Stream<GroupPermissionEntity> watchGroupPermission(String roomId) {
    return groupPermissionDb.watchByRoomId(roomId).asyncMap((collection) {
      return collection.toEntity();
    });
  }

  @override
  Future<List<GroupPermissionEntity>> getGroupPermissionWithIds(List<String> roomIds) async {
    final result = await groupPermissionDb.getGroupPermissionWithIds(roomIds);
    return result.map((e) => e.toEntity()).toList();
  }
}
