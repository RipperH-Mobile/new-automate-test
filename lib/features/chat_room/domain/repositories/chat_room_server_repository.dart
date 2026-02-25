import 'package:fpdart/fpdart.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/requests/leave_group_with_me_as_an_owner_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_secret_room_encryption_key_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_encryption_key_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_member_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/read_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/send_report_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_lock_message_password_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/share_file_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_last_typed_at_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_direct_chat_response.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_system_chat_response.dart';
import 'package:uchat/features/chat_room/domain/entities/room_encryption_key_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/secret_room_encryption_key_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_response.dart';

abstract class ChatRoomServerRepository {
  Future<void> triggerOfflineQueue();

  Future<OpenDirectChatResponse?> openDirectChat(OpenDirectChatRequest request);

  Future<OpenSystemChatResponse?> openSystemChat();

  Future<RoomMenuModel?> getDraftMenu(String roomId);

  Future<Either<dynamic, void>> resetCallStatus();

  Future<Either<dynamic, bool>> isCallStillAvailable(String roomId);

  Future<SecretRoomEncryptionKeyEntity?> getSecretRoomEncryptionKey(GetSecretRoomEncryptionKeyRequest request);

  Future<void> updateLastTypedAt(UpdateLastTypedAtRequest request);

  Future<Either<dynamic, void>> openSupportTicket({required OpenSupportTicketRequest request});

  Future<RoomEncryptionKeyEntity?> getRoomEncryptionKey(GetRoomEncryptionKeyRequest request);

  Future<PaginationPayload<RoomMemberEntity>> getMembersInRoom(GetRoomMembersRequest request);

  Future<Either<dynamic, bool>> notifyCaptureScreenInSecretChat(String roomId);

  Future<Either<dynamic, bool>> setLockMessagePassword(SetLockMessagePasswordRequest req);

  Future<void> shareFile(ShareFileRequest data);

  Future<void> triggerReadMessage(ReadMessageRequest data);

  Future<bool> checkIsOwner();

  Future<FindGroupResponse?> findGroup(FindGroupRequest request);

  Future<List<RoomEntity>?> getAllGroupRoomOwnByMe();

  Future<void> leaveGroupWithMeAsAnOwner(LeaveGroupWithMeAsAnOwnerRequest data);

  Future<GroupPermissionEntity?> getGroupPermission(String roomId);

  Future<GroupPermissionEntity> updateGroupPermission(GroupPermissionEntity permission);

  Future<RichMenuModel?> getOaRichMenu(String roomId);
}
