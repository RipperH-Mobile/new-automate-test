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

const allRoomLastSyncAtKey = 'ALL_ROOM_LAST_SEEN_LAST_SYNC';

class ChatRoomListApiService {
  ChatRoomListApiService({
    required this.httpCaller,
  });

  final HttpCaller httpCaller;

  Future<AcceptGroupInviteResponse?> acceptRoom(AcceptGroupInviteRequest request) async {
    final resp = await httpCaller.post(
      BackendPath.acceptRoomInvite.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
    return resp.mapToResponseV3(
      (data) => AcceptGroupInviteResponse.fromJson(data),
    );
  }

  Future<CreateSecretRoomResponse?> createSecretRoom(CreateSecretRoomRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.createSecretRoom.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse(
      (data) => CreateSecretRoomResponse.fromMap(data),
    );
  }

  Future<void> deleteRoom(String roomId) async {
    await httpCaller.delete(
      BackendPath.deleteRoom.http.replaceAll(':roomId', roomId),
    );
  }

  Future<void> deleteRoomWithCountdown(DeleteRoomWithCountdownRequest request) async {
    await httpCaller.delete(
      BackendPath.deleteRoomWithCountdown.http,
      data: request.toJson(),
    );
  }

  Future<void> undoDeleteRoomWithCountdown(UndoDeleteRoomWithCountdownRequest request) async {
    await httpCaller.delete(
      BackendPath.undoDeleteRoomWithCountdown.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  /// Get my chat room detail
  Future<RoomCollection?> fetchChatRoom(String roomId) async {
    final httpResp = await httpCaller.get(
      BackendPath.fetchChatRoom.http.replaceAll(':roomId', roomId),
    );

    return httpResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  /// to get default group avatar from server
  /// return list of default group avatar url
  Future<List<String>?> fetchDefaultGroupAvatar() async {
    final httpResp = await httpCaller.get(
      BackendPath.fetchDefaultGroupAvatar.http,
    );

    // Extract the data from HTTP response
    final httpData = httpResp.data;
    if (httpData is List) {
      return List<String>.from(httpData.whereType<String>());
    } else {
      throw Exception('Unexpected HTTP response format: ${httpData.runtimeType}');
    }
  }

  Future<List<GetAllRoomLastSeenResponse>?> getAllRoomLastSeen(GetAllRoomLastSeenRequest request) async {
    final httpResp = await httpCaller.get(
      BackendPath.getAllRoomLastSeen.http,
      data: request.toJson(),
    );

    return httpResp.listToResponse((e) => GetAllRoomLastSeenResponse.fromMap(e))?.toList();
  }

  Future<JoinGroupResponse?> joinGroup(JoinGroupRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.joinGroup.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );

    return httpResp.mapToResponseV3((data) => JoinGroupResponse.fromMap(data));
  }

  // TODO (improve) Maybe move code that execute after request is completed out of this function ? because this function should have only api calling code ?
  Future<RoomCollection?> leaveGroup(LeaveGroupRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.leaveGroup.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );

    return httpResp.mapToResponseV3(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<void> rejectRoom(RejectGroupInviteRequest request) async {
    await httpCaller.post(
      BackendPath.rejectRoomInvite.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  // TODO (improve) Maybe move code that execute after request is completed out of this function ? because this function should have only api calling code ?
  Future<RoomSubscriptionCollection?> toggleHideRoom(ToggleHideRoomRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.toggleHideRoom.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );
  }

  Future<RoomSubscriptionCollection?> togglePinRoom(TogglePinRoomRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.togglePinRoom.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );
  }

  Future<RoomSubscriptionCollection?> toggleMutedRoom(ToggleMuteRoomRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.toggleMuteRoom.http,
      data: request.toMap(),
    );

    final roomSubscription = httpResp.mapToResponse(
      (data) => RoomSubscriptionCollection.fromMap(data),
    );

    return roomSubscription;
  }

  Future<void> handleReadAll(ReadAllRequest request) async {
    await httpCaller.post(
      BackendPath.readAllRoom.http,
      data: request.toMap(),
    );
  }

  Future<UserResponse?> toggleChatCategory(ToggleChatCategoryRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.toggleChatCategory.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<UserResponse>(
      (data) => UserResponse.fromMap(data['data']),
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

  Future<InviteRoomEntity?> verifyInviteLink(String inviteLinkToken) async {
    final httpResp = await httpCaller.post(
      BackendPath.verifyInviteLink.http,
      data: {'token': inviteLinkToken},
    );

    return httpResp.mapToResponseV3((data) => InviteRoomEntity.fromMap(data));
  }
}
