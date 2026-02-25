import 'package:isar_community/isar.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/group_member_role_model.dart';
import 'package:uchat/utils/fast_hash.dart';

typedef IsarRoomMemberCollection = IsarCollection<RoomMemberCollection>;

final _log = useLogger();

class RoomMemberDb {
  Isar? customDbInstance;

  RoomMemberDb({this.customDbInstance});

  // Start body
  Isar get dbInstance {
    return customDbInstance ?? DbManager().authenticatedInstance!;
  }

  IsarRoomMemberCollection get roomMemberCollection {
    return dbInstance.roomMember;
  }

  Future<void> putRoomMember(RoomMemberCollection member) async {
    await dbInstance.writeTxn(() async {
      try {
        final localMember = await getOneMemberInRoom(
          member.roomId!,
          member.accountId!,
        );
        if (localMember != null) {
          localMember.update(member);
          await roomMemberCollection.put(localMember);
        } else {
          await roomMemberCollection.put(member);
        }
      } catch (e, stacktrace) {
        _log.e('putRoomMember error', e, stacktrace);
      }
    });
  }

  Future<void> putRoomMemberWithoutTxn(RoomMemberCollection member) async {
    try {
      final localMember = await getOneMemberInRoom(
        member.roomId!,
        member.accountId!,
      );
      if (localMember != null) {
        localMember.update(member);
        await roomMemberCollection.put(localMember);
      } else {
        await roomMemberCollection.put(member);
      }
    } catch (e, stacktrace) {
      _log.e('putRoomMemberWithoutTxn error', e, stacktrace);
    }
  }

  /// Update all room member in local db with [memberList]'s data.
  Future<void> updateAllRoomMember(List<RoomMemberCollection> members) async {
    await dbInstance.writeTxn(() async {
      for (final member in members) {
        await putRoomMemberWithoutTxn(member);
      }
    });
  }

  /// Put and replace all room member in local db with [memberList]'s data.
  Future<void> putAllRoomMember(List<RoomMemberCollection> memberList) async {
    await dbInstance.writeTxn(() async {
      await roomMemberCollection.putAll(memberList);
    });
  }

  Future<void> putAllRoomMemberWithoutTxn(List<RoomMemberCollection> memberList) async {
    await roomMemberCollection.putAll(memberList);
  }

  /// Update all room member in local db with [memberList]'s data.
  Future<void> updateAllRoomMemberWithoutTxn(
    List<RoomMemberCollection> members,
  ) async {
    for (final member in members) {
      await putRoomMemberWithoutTxn(member);
    }
  }

  Future<RoomMemberCollection?> getFirstOtherInRoom(String roomId) async {
    String? currentUserId = UserController.instance.currentUser()?.id;
    return await roomMemberCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .not()
        .accountIdEqualTo(currentUserId)
        .findFirst();
  }

  // TODO This does not return only the first other, it returns all others in the rooms. Change function name ?
  Future<List<RoomMemberCollection>?> getAllFirstOtherInRoom(List<String> roomIds) async {
    String? currentUserId = UserController.instance.currentUser()?.id;
    return await roomMemberCollection
        .where()
        .anyOf(roomIds, (q, String roomId) => q.roomIdEqualTo(roomId))
        .filter()
        .not()
        .accountIdEqualTo(currentUserId)
        .findAll();
  }

  RoomMemberCollection? getFirstOtherInRoomSync(String roomId) {
    return roomMemberCollection.where().roomIdEqualTo(roomId).filter().isMeEqualTo(false).findFirstSync();
  }

  RoomMemberCollection? getMeInRoomSync(String roomId) {
    return roomMemberCollection.where().roomIdEqualTo(roomId).filter().isMeEqualTo(true).findFirstSync();
  }

  Future<List<RoomMemberCollection>?> getAllMemberInRoom(String roomId) async {
    return await roomMemberCollection
        .where()
        .roomIdEqualTo(roomId)
        .sortByNameLowercase()
        .thenByName()
        .thenByAccountId()
        .findAll();
  }

  Future<List<RoomMemberCollection>> getAllMemberInRoomWithPagination({
    required String roomId,
    String? keyword,
    int page = 1,
    int pageSize = UChatConstant.pageSizeMembersInGroup,
  }) async {
    if (keyword != null) {
      return await roomMemberCollection
          .where()
          .roomIdEqualTo(roomId)
          .filter()
          .nameContains(keyword)
          .sortByIsOwnerDesc()
          .thenByNameLowercase()
          .thenByName()
          .thenByAccountId()
          .offset((page - 1) * pageSize)
          .limit(pageSize)
          .findAll();
    } else {
      return await roomMemberCollection
          .where()
          .roomIdEqualTo(roomId)
          .sortByIsOwnerDesc()
          .thenByNameLowercase()
          .thenByName()
          .thenByAccountId()
          .offset((page - 1) * pageSize)
          .limit(pageSize)
          .findAll();
    }
  }

  Future<int> getMemberInRoomWithPaginationCount({
    required String roomId,
    String? keyword,
  }) async {
    if (keyword != null) {
      return await roomMemberCollection.where().roomIdEqualTo(roomId).filter().nameContains(keyword).count();
    } else {
      return await roomMemberCollection.where().roomIdEqualTo(roomId).count();
    }
  }

  Future<List<RoomMemberCollection>> getPromotableMembers({
    required String roomId,
    String? keyword,
    int page = 1,
    int pageSize = UChatConstant.pageSizeMembersInGroup,
  }) async {
    QueryBuilder<RoomMemberCollection, RoomMemberCollection, QAfterFilterCondition> query =
        roomMemberCollection.where().roomIdEqualTo(roomId).filter().isAdminOrAboveEqualTo(false);
    if (keyword != null) {
      query = query.nameContains(keyword);
    }
    return await query
        .sortByNameLowercase()
        .thenByName()
        .thenByAccountId()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAll();
  }

  Future<List<RoomMemberCollection>> getAllAdminAndOwner({
    required String roomId,
    String? keyword,
    int page = 1,
    int pageSize = UChatConstant.pageSizeMembersInGroup,
  }) async {
    if (keyword != null && keyword != '') {
      return await roomMemberCollection
          .where()
          .roomIdEqualTo(roomId)
          .filter()
          .isAdminOrAboveEqualTo(true)
          .group((q) => q
              .nameContains(keyword)
              .or()
              .groupRole((q) => q.roleContains(keyword))
              .or()
              .groupRole((q) => q.customAdminNameIsNotNull().customAdminNameContains(keyword)))
          .sortByIsOwnerDesc()
          .thenByNameLowercase()
          .thenByName()
          .thenByAccountId()
          .offset((page - 1) * pageSize)
          .limit(pageSize)
          .findAll();
    } else {
      return await roomMemberCollection
          .where()
          .roomIdEqualTo(roomId)
          .filter()
          .isAdminOrAboveEqualTo(true)
          .sortByIsOwnerDesc()
          .thenByNameLowercase()
          .thenByName()
          .thenByAccountId()
          .offset((page - 1) * pageSize)
          .limit(pageSize)
          .findAll();
    }
  }

  Future<List<RoomMemberCollection>> getAllMemberAndAdmin({
    required String roomId,
    String? keyword,
    int page = 1,
    int pageSize = UChatConstant.pageSizeMembersInGroup,
  }) async {
    if (keyword != null && keyword != '') {
      return await roomMemberCollection
          .where()
          .roomIdEqualTo(roomId)
          .filter()
          .isOwnerEqualTo(false)
          .and()
          .group(
            (q) => q.nameContains(keyword).or().groupRole((r) => r.roleContains(keyword)),
          )
          .sortByIsAdminDesc()
          .thenByNameLowercase()
          .thenByName()
          .thenByAccountId()
          .offset((page - 1) * pageSize)
          .limit(pageSize)
          .findAll();
    } else {
      return await roomMemberCollection
          .where()
          .roomIdEqualTo(roomId)
          .filter()
          .isOwnerEqualTo(false)
          .sortByIsAdminDesc()
          .thenByNameLowercase()
          .thenByName()
          .thenByAccountId()
          .offset((page - 1) * pageSize)
          .limit(pageSize)
          .findAll();
    }
  }

  Future<List<RoomMemberCollection>> getNextOwnerSuggestionList({
    required String roomId,
  }) async {
    return await roomMemberCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .isOwnerEqualTo(false)
        .sortByIsAdminDesc()
        .thenByJoinedAtDesc()
        .thenByName()
        .thenByAccountId()
        .limit(6)
        .findAll();
  }

  Future<int> getNextOwnerSuggestionListCount({
    required String roomId,
  }) async {
    return await roomMemberCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .isOwnerEqualTo(false)
        .sortByIsAdminDesc()
        .thenByJoinedAtDesc()
        .thenByName()
        .thenByAccountId()
        .count();
  }

  List<String?> getAllAdminIdInRoomSync(String roomId) {
    return roomMemberCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .isAdminEqualTo(true)
        .accountIdProperty()
        .findAllSync();
  }

  String? getOwnerIdInRoomSync(String roomId) {
    return roomMemberCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .isOwnerEqualTo(true)
        .accountIdProperty()
        .findFirstSync();
  }

  Future<List<RoomMemberCollection>?> searchMemberInRoom(
    String roomId,
    String name,
  ) async {
    return await roomMemberCollection
        .where()
        .roomIdEqualTo(roomId)
        .filter()
        .nameContains(name)
        .sortByNameLowercase()
        .thenByName()
        .thenByAccountId()
        .findAll();
  }

  List<RoomMemberCollection>? getAllMemberInRoomSync(String roomId) {
    return roomMemberCollection.where().roomIdEqualTo(roomId).findAllSync();
  }

  Future<int> getMemberCount(String roomId) async {
    return roomMemberCollection.where().roomIdEqualTo(roomId).count();
  }

  Future<RoomMemberCollection?> getOneMemberInRoom(String roomId, String accountId) async {
    return await roomMemberCollection.where().roomIdEqualTo(roomId).filter().accountIdEqualTo(accountId).findFirst();
  }

  RoomMemberCollection? getOneMemberInRoomSync(String roomId, String accountId) {
    return roomMemberCollection.where().roomIdEqualTo(roomId).filter().accountIdEqualTo(accountId).findFirstSync();
  }

  Future<List<RoomMemberCollection>?> getAllMemberWithId(String accountId) async {
    return await roomMemberCollection.filter().accountIdEqualTo(accountId).findAll();
  }

  RoomMemberCollection? getOneMemberInAnyRoomSync(String accountId) {
    return roomMemberCollection.filter().accountIdEqualTo(accountId).findFirstSync();
  }

  Future<List<RoomMemberCollection>> getMemberWithIdInSecretChat(String accountId) async {
    return await roomMemberCollection
        .filter()
        .accountIdEqualTo(accountId)
        .roomTypeEqualTo(RoomType.directSecret)
        .findAll();
  }

  Future<void> deleteMemberWithoutTxn(String id) async {
    await roomMemberCollection.delete(fastHash(id));
  }

  Future<List<RoomMemberCollection>> getNextOwnerSuggestion(String roomId, String ownerAccountId) async {
    return await roomMemberCollection
        .filter()
        .not()
        .accountIdEqualTo(ownerAccountId)
        .roomIdEqualTo(roomId)
        .sortByJoinedAt()
        .limit(2)
        .findAll();
  }

  Future<String?> getDirectRoomIdByOtherIdInRoom(String accountId) async {
    return await roomMemberCollection
        .filter()
        .accountIdEqualTo(accountId)
        .isDirectEqualTo(true)
        .roomIdProperty()
        .findFirst();
  }

  Future<String?> getDirectOrSystemRoomIdByOtherIdInRoom(String accountId) async {
    return await roomMemberCollection
        .filter()
        .accountIdEqualTo(accountId)
        .group((q) => q.isDirectEqualTo(true).or().isSystemEqualTo(true))
        .roomIdProperty()
        .findFirst();
  }

  String? getDirectRoomIdByOtherIdInRoomSync(String accountId) {
    return roomMemberCollection
        .filter()
        .accountIdEqualTo(accountId)
        .isDirectEqualTo(true)
        .roomIdProperty()
        .findFirstSync();
  }

  Future<void> clearCollection() async {
    await roomMemberCollection.clear();
  }

  Future<void> deleteMemberInRoom(String roomId) async {
    await dbInstance.writeTxn(() async {
      await roomMemberCollection.where().roomIdEqualTo(roomId).deleteAll();
    });
  }

  Future<void> deleteMemberInRoomWithoutTxn(String roomId) async {
    await roomMemberCollection.where().roomIdEqualTo(roomId).deleteAll();
  }
}
