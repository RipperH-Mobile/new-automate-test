import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/create_secret_room_response_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/get_all_room_last_seen_entity.dart';
import 'package:uchat/features/chat_room/data/models/requests/accept_group_invite_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/create_secret_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/delete_room_with_countdown_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_all_room_last_seen_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/join_group_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/leave_group_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/reject_group_invite_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_chat_category_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_hide_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_mute_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/toggle_pin_room_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/undo_delete_room_with_countdown_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_hide_message_notification_request.dart';
import 'package:uchat/features/chat_room_list/data/models/join_group_response.dart';
import 'package:uchat/features/chat_room_list/data/models/read_all_request.dart';
import 'package:uchat/features/chat_room_list/domain/entities/invite_room_entity.dart';

abstract class ChatRoomListServerRepository {
  Future<void> deleteRoom(String roomId);

  Future<void> acceptRoom(AcceptGroupInviteRequest request);

  Future<CreateSecretRoomResponseEntity?> createSecretRoom(CreateSecretRoomRequest request);

  Future<RoomEntity?> fetchChatRoom(String roomId);

  Future<List<String>> fetchDefaultGroupAvatar();

  Future<JoinGroupResponse?> joinGroup(JoinGroupRequest request);

  Future<RoomEntity?> leaveGroup(LeaveGroupRequest request);

  Future<void> rejectRoom(RejectGroupInviteRequest request);

  Future<RoomSubscriptionEntity?> toggleHideRoom(ToggleHideRoomRequest request);

  Future<RoomSubscriptionEntity?> togglePinRoom(TogglePinRoomRequest request);

  Future<List<GetAllRoomLastSeenEntity>?> getAllRoomLastSeen(GetAllRoomLastSeenRequest request);

  Future<void> readAllRoom(ReadAllRequest request);

  Future<RoomSubscriptionEntity?> toggleMutedRoom(ToggleMuteRoomRequest request);

  Future<bool> toggleChatCategory(ToggleChatCategoryRequest request);

  Future<void> deleteRoomWithCountdown(DeleteRoomWithCountdownRequest request);

  Future<void> undoDeleteRoomWithCountdown(UndoDeleteRoomWithCountdownRequest room);

  Future<RoomSubscriptionEntity?> toggleHideMessageNotification(ToggleHideMessageNotificationRequest request);

  Future<InviteRoomEntity?> verifyInviteLink(String inviteLinkToken);
}
