import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
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

abstract class ChatRoomDetailLocalRepository {
  // roomMemberDb
  Future<List<RoomMemberEntity>> getNextOwnerSuggestion(GetNextOwnerSuggestionRequest request);

  Future<RoomMemberEntity?> getOneMemberInRoom(GetOneMemberInRoomRequest request);

  RoomMemberEntity? getOneMemberSync(GetOneMemberInRoomRequest request);

  RoomMemberEntity? getOneMemberInAnyRoomSync(GetOneMemberInAnyRoomRequest request);

  Future<List<RoomMemberEntity>> getMembersInRoom(GetRoomDetailMemberAndPendingRequest request);

  Future<int> getMembersInRoomCount({required String roomId, String? keyword});

  Future<List<RoomMemberEntity>> getPromotableMembers(GetPromotableMembersRequest request);

  // roomSubDb
  Future<RoomSubscriptionEntity?> getRoomSubscriptionWithRoomId(GetRoomSubscriptionWithRoomIdRequest request);

  Future<RoomSubscriptionEntity?> putRoomSubscription(PutRoomSubscriptionRequest request);

  // roomFileDb
  Future<PaginationPayload<RoomFileEntity>> getAllFileInRoom(FetchRoomFileRequest request);

  Future<PaginationPayload<RoomFileEntity>> getPhotosAndVideosInRoom(GetPhotosAndVideosInRoomRequest request);

  Future<void> putAllRoomFile(PutAllRoomFileRequest request);

  Future<void> deleteAllFileInRoom(DeleteAllFileInRoomRequest request);

  // configDb
  Future<int?> getFileSeq(GetFileSeqRequest request);

  Future<void> saveConfig(SaveConfigRequest request);

  //messageDb
  // TODO: message entity
  Future<List<MessageCollection>> getAllSentMessageWithFile(GetAllSentMessageWithFileRequest request);

  Future<List<RoomMemberEntity>> getAllAdminAndOwner(GetAllAdminRequest request);

  Future<List<RoomMemberEntity>> getAllMemberAndAdmin(GetAllMemberAndAdminRequest request);

  Future<List<RoomMemberEntity>> searchMemberInRoom(String roomId, String name);

  Future<List<RoomMemberEntity>> getNextOwnerSuggestionList(GetNextOwnerSuggestionListRequest request);

  Future<int> getNextOwnerSuggestionListCount(GetNextOwnerSuggestionListRequest request);

  Future<RoomInviteLinkEntity> getRoomInviteLink(String roomId);

  Future<void> updateRoomInviteLink(RoomInviteLinkEntity entity);
}
