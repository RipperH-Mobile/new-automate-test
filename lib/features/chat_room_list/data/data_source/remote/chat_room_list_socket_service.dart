import 'dart:async';

import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
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
import 'package:uchat/features/chat_room/data/models/responses/accept_group_invite_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/create_secret_room_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_all_room_last_seen_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/toggle_hide_message_notification_request.dart';
import 'package:uchat/features/chat_room_list/data/models/join_group_response.dart';
import 'package:uchat/features/chat_room_list/data/models/read_all_request.dart';
import 'package:uchat/features/chat_room_list/domain/entities/invite_room_entity.dart';

// TODO: use model request generate
// TODO: move model folder

class ChatRoomListSocketService {
  ChatRoomListSocketService({
    required this.socketCaller,
  });

  final SocketCaller socketCaller;

  Future<AcceptGroupInviteResponse?> acceptRoom(AcceptGroupInviteRequest request) async {
    final resp = await socketCaller.emitCall(
      BackendPath.acceptRoomInvite.socket,
      request.toJson(),
    );
    return resp.mapToResponse(
      (data) => AcceptGroupInviteResponse.fromJson(data),
    );
  }

  Future<CreateSecretRoomResponse?> createSecretRoom(CreateSecretRoomRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.createSecretRoom.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse(
      (data) => CreateSecretRoomResponse.fromMap(data),
    );
  }

  Future<void> deleteRoom(String roomId) async {
    await socketCaller.emitCall(
      BackendPath.deleteRoom.socket,
      {'roomId': roomId},
    );
  }

  Future<void> deleteRoomWithCountdown(DeleteRoomWithCountdownRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.deleteRoomWithCountdown.socket,
      request.toJson(),
    );
  }

  Future<void> undoDeleteRoomWithCountdown(UndoDeleteRoomWithCountdownRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.undoDeleteRoomWithCountdown.socket,
      request.toJson(),
    );
  }

  /// Get my chat room detail
  Future<RoomCollection?> fetchChatRoom(String roomId) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.fetchChatRoom.socket,
      {
        'roomId': roomId,
      },
    );

    return socketResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
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

  Future<List<GetAllRoomLastSeenResponse>?> getAllRoomLastSeen(GetAllRoomLastSeenRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.getAllRoomLastSeen.socket,
      request.toJson(),
    );

    return socketResp.listToResponse((e) => GetAllRoomLastSeenResponse.fromMap(e))?.toList();
  }

  Future<JoinGroupResponse?> joinGroup(JoinGroupRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.joinGroup.socket,
      request.toJson(),
    );

    return socketResp.mapToResponseV3((data) => JoinGroupResponse.fromMap(data));
  }

  Future<RoomCollection?> leaveGroup(LeaveGroupRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.leaveGroup.socket,
      request.toJson(),
    );

    return socketResp.mapToResponseV3(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<void> rejectRoom(RejectGroupInviteRequest request) async {
    await socketCaller.emitCall(
      BackendPath.rejectRoomInvite.socket,
      request.toJson(),
    );
  }

  Future<RoomSubscriptionCollection?> toggleHideRoom(ToggleHideRoomRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.toggleHideRoom.socket,
      request.toJson(),
    );

    return socketResp.mapToResponseV3(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );
  }

  Future<RoomSubscriptionCollection?> togglePinRoom(TogglePinRoomRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.togglePinRoom.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );
  }

  Future<RoomSubscriptionCollection?> toggleMutedRoom(ToggleMuteRoomRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.toggleMuteRoom.socket,
      request.toMap(),
    );

    final roomSubscription = socketResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );

    return roomSubscription;
  }

  Future<void> handleReadAll(ReadAllRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.readAllRoom.socket,
      request.toMap(),
    );
  }

  Future<UserResponse?> toggleChatCategory(ToggleChatCategoryRequest request) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.toggleChatCategory.socket,
      request.toMap(),
    );

    return socketResp.mapToResponse<UserResponse>(
      (data) => UserResponse.fromMap(data['data']),
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

  Future<InviteRoomEntity?> verifyInviteLink(String inviteLinkToken) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.verifyInviteLink.socket,
      {'token': inviteLinkToken},
    );

    return socketResp.mapToResponseV3(
      (data) => InviteRoomEntity.fromMap(data),
    );
  }
}
