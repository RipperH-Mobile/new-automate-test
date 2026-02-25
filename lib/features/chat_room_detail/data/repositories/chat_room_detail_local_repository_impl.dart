import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/entities/enum/invite_link_status.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room_detail/data/data_source/local/room_invite_link_db.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_invite_link_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/delete_all_file_in_room_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/fetch_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_all_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_all_member_and_admin_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_all_sent_message_with_file_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_file_seq_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_next_owner_suggestion_list_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_next_owner_suggestion_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_one_member_in_any_room_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_one_member_in_room_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_photos_and_videos_in_room_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_promotable_members_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_room_detail_waiting_list_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_room_subscription_with_room_id_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/put_all_room_file_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/put_room_subscription_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/save_config_request.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_link_entity.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';

class ChatRoomDetailLocalRepositoryImpl implements ChatRoomDetailLocalRepository {
  final RoomMemberDb roomMemberDb;
  final RoomSubscriptionDb roomSubDb;
  final RoomFileDb roomFileDb;
  final RoomDb roomDb;
  final ConfigDb configAuthenticated;
  final MessageDb messageDb;
  final RoomInviteLinkDb roomInviteLinkDb;

  ChatRoomDetailLocalRepositoryImpl({
    required this.roomMemberDb,
    required this.roomSubDb,
    required this.roomFileDb,
    required this.roomDb,
    required this.configAuthenticated,
    required this.messageDb,
    required this.roomInviteLinkDb,
  });

  @override
  Future<PaginationPayload<RoomFileEntity>> getAllFileInRoom(FetchRoomFileRequest request) async {
    final roomFiles = await roomFileDb.getAllFileInRoom(
      roomId: request.roomId,
      page: request.page,
      pageSize: request.pageSize,
    );
    int total = await roomFileDb.getFileCountInRoom(roomId: request.roomId);
    return PaginationPayload<RoomFileEntity>(
      data: roomFiles.map((e) => e.toEntity()),
      total: total,
      page: request.page,
      pageSize: request.pageSize,
      totalPages: (total / request.pageSize).ceil(),
    );
  }

  @override
  Future<int?> getFileSeq(GetFileSeqRequest request) async {
    final fileSeqConfigKey = ConfigDb.getBoxFileFirstSequenceConfigKey(request.roomId);
    return await configAuthenticated.authenticated.getInt(
      key: fileSeqConfigKey,
    );
  }

  @override
  Future<List<RoomMemberEntity>> getNextOwnerSuggestion(GetNextOwnerSuggestionRequest request) async {
    final nextOwnerSuggestion = await roomMemberDb.getNextOwnerSuggestion(
      request.roomId,
      request.accountId,
    );
    return nextOwnerSuggestion.map((e) => e.toEntity()).toList();
  }

  @override
  Future<RoomMemberEntity?> getOneMemberInRoom(GetOneMemberInRoomRequest request) async {
    final member = await roomMemberDb.getOneMemberInRoom(
      request.roomId,
      request.accountId,
    );
    return member?.toEntity();
  }

  @override
  RoomMemberEntity? getOneMemberSync(GetOneMemberInRoomRequest request) {
    final member = roomMemberDb.getOneMemberInRoomSync(
      request.roomId,
      request.accountId,
    );

    return member?.toEntity();
  }

  @override
  RoomMemberEntity? getOneMemberInAnyRoomSync(GetOneMemberInAnyRoomRequest request) {
    final member = roomMemberDb.getOneMemberInAnyRoomSync(
      request.accountId,
    );

    return member?.toEntity();
  }

  @override
  Future<PaginationPayload<RoomFileEntity>> getPhotosAndVideosInRoom(
    GetPhotosAndVideosInRoomRequest request,
  ) async {
    final roomFiles = await roomFileDb.getPhotosAndVideosInRoom(
      roomId: request.roomId,
      page: request.page,
      pageSize: request.pageSize,
    );
    int total = await roomFileDb.getPhotoAndVideoCountInRoom(roomId: request.roomId);
    return PaginationPayload<RoomFileEntity>(
      data: roomFiles.map((e) => e.toEntity()),
      total: total,
      page: request.page,
      pageSize: request.pageSize,
      totalPages: (total / request.pageSize).ceil(),
    );
  }

  @override
  Future<RoomSubscriptionEntity?> getRoomSubscriptionWithRoomId(GetRoomSubscriptionWithRoomIdRequest request) async {
    final roomSub = await roomSubDb.getRoomSubscriptionWithRoomId(
      request.id,
    );

    return roomSub?.toEntity();
  }

  @override
  Future<void> putAllRoomFile(PutAllRoomFileRequest request) async {
    await roomFileDb.putAllRoomFile(request.roomFiles);
  }

  @override
  Future<RoomSubscriptionEntity?> putRoomSubscription(PutRoomSubscriptionRequest request) async {
    final result = await roomSubDb.putRoomSubscription(
      RoomSubscriptionCollection.fromEntity(request.roomSub),
      replaceData: request.replaceData,
    );

    return result?.toEntity();
  }

  // TODO (refactor clean) Move this somewhere ? save config is used in all feature it shouldn't be here.
  @override
  Future<void> saveConfig(SaveConfigRequest request) async {
    await configAuthenticated.authenticated.saveConfig(
      key: request.key,
      value: request.value,
    );
  }

  @override
  Future<void> deleteAllFileInRoom(DeleteAllFileInRoomRequest request) async {
    await roomFileDb.deleteAllFileInRoom(request.roomId);
  }

  @override
  Future<List<MessageCollection>> getAllSentMessageWithFile(
    GetAllSentMessageWithFileRequest request,
  ) async {
    return await messageDb.getAllSentMessageWithFile(roomId: request.roomId);
  }

  @override
  Future<List<RoomMemberEntity>> getMembersInRoom(GetRoomDetailMemberAndPendingRequest request) async {
    final members = await roomMemberDb.getAllMemberInRoomWithPagination(
      roomId: request.roomId,
      keyword: request.keyword,
      page: request.page,
      pageSize: request.pageSize,
    );
    return members.map((e) => e.toEntity()).toList();
  }

  @override
  Future<int> getMembersInRoomCount({required String roomId, String? keyword}) async {
    return await roomMemberDb.getMemberInRoomWithPaginationCount(
      roomId: roomId,
      keyword: keyword,
    );
  }

  @override
  Future<List<RoomMemberEntity>> getPromotableMembers(GetPromotableMembersRequest request) async {
    final result = await roomMemberDb.getPromotableMembers(
      roomId: request.roomId,
      keyword: request.keyword,
      page: request.page,
      pageSize: request.pageSize,
    );
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RoomMemberEntity>> getAllAdminAndOwner(GetAllAdminRequest request) async {
    final result = await roomMemberDb.getAllAdminAndOwner(
      roomId: request.roomId,
      keyword: request.keyword,
      page: request.page,
      pageSize: request.pageSize,
    );
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RoomMemberEntity>> getAllMemberAndAdmin(GetAllMemberAndAdminRequest request) async {
    final result = await roomMemberDb.getAllMemberAndAdmin(
      roomId: request.roomId,
      keyword: request.keyword,
      page: request.page,
      pageSize: request.pageSize,
    );
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RoomMemberEntity>> searchMemberInRoom(String roomId, String name) async {
    final result = await roomMemberDb.searchMemberInRoom(roomId, name);
    if (result == null) {
      return [];
    }

    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<RoomMemberEntity>> getNextOwnerSuggestionList(GetNextOwnerSuggestionListRequest request) async {
    final result = await roomMemberDb.getNextOwnerSuggestionList(
      roomId: request.roomId,
    );
    return result.map((e) => e.toEntity()).toList();
  }

  @override
  Future<int> getNextOwnerSuggestionListCount(GetNextOwnerSuggestionListRequest request) async {
    final result = await roomMemberDb.getNextOwnerSuggestionListCount(
      roomId: request.roomId,
    );
    return result;
  }

  @override
  Future<RoomInviteLinkEntity> getRoomInviteLink(String roomId) async {
    final inviteLink = await roomInviteLinkDb.getByRoomId(roomId);
    if (inviteLink != null) {
      return inviteLink.toEntity();
    } else {
      // Return a default entity if not found
      return RoomInviteLinkEntity(roomId: roomId, inviteLink: null, enable: InviteLinkStatus.off);
    }
  }

  @override
  Future<void> updateRoomInviteLink(RoomInviteLinkEntity entity) async {
    await roomInviteLinkDb.save(RoomInviteLinkCollection.fromEntity(entity));
  }
}
