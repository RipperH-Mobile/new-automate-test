import 'dart:async';
import 'package:uchat/api/api.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/pin_message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/delete_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/delete_other_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_message_from_server_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_message_react_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_encryption_key_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_room_member_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_secret_room_encryption_key_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/leave_group_with_me_as_an_owner_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/open_direct_chat_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/react_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/read_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/send_report_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/set_lock_message_password_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/update_last_typed_at_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_message_from_server_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_room_encryption_key_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_secret_room_encryption_key_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_direct_chat_response.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/get_message_reaction_model.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_system_chat_response.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_response.dart';

// TODO: use model request generate
// TODO: move model folder

class ChatRoomSocketService {
  ChatRoomSocketService({
    required this.socketCaller,
  });

  final SocketCaller socketCaller;

  Future<void> triggerReadMessage(ReadMessageRequest request) async {
    await socketCaller.emitCall(
      BackendPath.triggerReadMessage.socket,
      request.toJson(),
    );
  }

  Future<OpenDirectChatResponse?> openDirectChat(
    OpenDirectChatRequest request,
  ) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.openDirectChat.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse<OpenDirectChatResponse>(
      (data) => OpenDirectChatResponse.fromMap(data),
    );
  }

  Future<OpenSystemChatResponse?> openSystemChat() async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.openSystemChat.socket,
      {},
    );

    return socketResp.mapToResponseV3<OpenSystemChatResponse>(
      (data) => OpenSystemChatResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<RoomMemberCollection>> getMembersInRoom(
    GetRoomMembersRequest request,
  ) async {
    final response = await socketCaller.emitCallV3(
      BackendPath.getMembersInRoom.socket,
      request.toJson(),
    );

    return PaginationPayload.fromMapV3(
      response.data,
      listMapper: (rows) {
        List<RoomMemberCollection> result = [];
        for (final row in rows) {
          result.add(RoomMemberCollection.fromMap(row));
        }
        return result;
      },
    );
  }

  Future<bool?> setLockMessagePassword(SetLockMessagePasswordRequest req) async {
    final res = await socketCaller.emitCall(
      BackendPath.setLockMessagePassword.socket,
      req.toJson(),
    );

    return res.data;
  }

  Future<GetMessageFromServerResponse?> getMessages(
    GetMessageFromServerRequest request, {
    Duration timeout = emitCallTimeout,
  }) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getMessages.socket,
      request.toMap(),
      timeout: timeout,
    );

    return GetMessageFromServerResponse(
      messages: socketResp.listToResponseV3((e) => MessageCollection.fromMap(e))?.toList(),
    );
  }

  Future<SendMessageResponse?> sendMessage(
    final SendMessageRequest request,
  ) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.sendMessage.socket,
      request.toMap(),
    );

    return SendMessageResponse.fromMap(socketResp.data);
  }

  Future<void> uploadFilesConfirm(UploadFilesConfirmRequest request) async {
    await socketCaller.emitCall(
      BackendPath.uploadFileConfirm.socket,
      request.toMap(),
    );
  }

  Future<void> saveToBookmark(SaveBookmarkRequest request) async {
    await socketCaller.emitCall(
      BackendPath.saveToBookmark.socket,
      request.toMap(),
    );
  }

  Future<void> removeFromBookmark(RemoveBookmarkRequest request) async {
    await socketCaller.emitCall(
      BackendPath.removeFromBookmark.socket,
      request.toMap(),
    );
  }

  Future<void> unsentMessage(UnsentMessageRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.unsendMessageV3.socket,
      {'messages': request.toListMap()},
    );
  }

  Future<void> removeMessage(DeleteMessageRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.removeMessageV3.socket,
      {'messages': request.toListMap()},
    );
  }

  Future<void> removeOtherMessage(DeleteOtherMessageRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.removeOtherMessageV3.socket,
      {
        'roomId': request.roomId,
        'messages': request.toListMap(),
      },
    );
  }

  Future<MessageEntity?> editMessage(EditMessageRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.editMessage.socket,
      request.toMap(),
    );

    return res.mapToResponseV3<MessageEntity>(
      (result) => MessageEntity.fromJson(result),
    );
  }

  Future<MessageReactionResponse?> reactMessage(ReactMessageRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.reactMessage.socket,
      request.toJson(),
    );

    return res.mapToResponseV3<MessageReactionResponse>(
      (result) => MessageReactionResponse.fromMap(result),
    );
  }

  Future<PaginationPayload<GetMessageReactionModel>?> getMessageReact(GetMessageReactRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.getMessageReact.socket,
      request.toJsonData(),
    );
    return res.mapToResponse((e) {
      return PaginationPayload<GetMessageReactionModel>.fromMapV3(
        e,
        listMapper: (data) => (data).map((item) => GetMessageReactionModel.fromJson(item)).toList(),
      );
    });
  }

  Future<PinMessageCollection?> pinMessage(PinMessageRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.pinMessage.socket,
      request.toJsonSocket(),
    );

    return res.mapToResponseV3<PinMessageCollection>(
      (data) => PinMessageCollection.fromJson(data),
    );
  }

  Future<void> unpinMessage(UnpinMessageRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.unpinMessage.socket,
      request.toJsonSocket(),
    );
  }

  Future<void> unpinAllMessages(UnpinAllMessagesRequest request) async {
    await socketCaller.emitCallV3(
      BackendPath.unpinAllMessages.socket,
      request.toJson(),
    );
  }

  Future<PaginationPayload<PinMessageCollection>?> getPinMessages(GetPinMessagesRequest request) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.getPinMessages.socket,
      request.toJson(),
    );
    return res.mapToResponse<PaginationPayload<PinMessageCollection>?>((e) {
      return PaginationPayload<PinMessageCollection>.fromMapV3(
        e,
        listMapper: (data) => (data).map((item) => PinMessageCollection.fromJson(item)).toList(),
      );
    });
  }

  Future<void> openSupportTicket(
    OpenSupportTicketRequest request,
  ) async {
    await socketCaller.emitCall(
      BackendPath.openSupportTicket.socket,
      request.toJson(),
    );
  }

  Future<GetSecretRoomEncryptionKeyResponse?> getSecretRoomEncryptionKey(
    GetSecretRoomEncryptionKeyRequest request,
  ) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.getEncryptionKey.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse(
      (data) => GetSecretRoomEncryptionKeyResponse.fromMap(data),
    );
  }

  /// Get public key of the requested room.
  /// If the requested room doesn't have public key, The value in response will be '{}'
  Future<GetRoomEncryptionKeyResponse?> getRoomEncryptionKey(GetRoomEncryptionKeyRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.getRoomEncryptionKey.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse((data) => GetRoomEncryptionKeyResponse.fromMap(data));
  }

  /// Update last type at to server
  Future<void> updateLastTypedAt(UpdateLastTypedAtRequest request) async {
    await socketCaller.emitCall(
      BackendPath.updateLastTypedAt.socket,
      request.toJson(),
    );
  }

  /// [Hybrid]
  Future<bool?> notifyCaptureScreenInSecretChat(String roomId) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.notifyCaptureScreenInSecretChat.socket,
      {'roomId': roomId},
    );

    return socketResp.data;
  }

  Future<RoomCollection?> getDraftMenu(String roomId) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.getDraftMenu.socket,
      {'roomId': roomId},
    );

    return socketResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  //TODO: fix model
  Future<bool> isCallStillAvailable(String roomId) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.isCallStillAvailable.socket,
      {'roomId': roomId},
    );
    return socketResp.data;
  }

  Future<bool> checkIsOwner() async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.checkIsOwner.socket,
      {},
    );

    return socketResp.data['data']['hasOwnerRoom'];
  }

  Future<FindGroupResponse?> findGroup(FindGroupRequest request) async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.findGroup.socket,
      request.toJson(),
    );

    return socketResp.mapToResponse<FindGroupResponse>(
      (data) => FindGroupResponse.fromJson(data),
    );
  }

  Future<List<RoomCollection>?> getAllGroupRoomOwnByMe() async {
    final socketResp = await socketCaller.emitCall(
      BackendPath.getRoomOwnByMe.socket,
      {
        'isIgnoreOnlyMe': true,
      },
    );

    List<RoomCollection> dataList = [];
    final rows = socketResp.data['rows'];

    for (final row in rows) {
      dataList.add(RoomCollection.fromMap(row));
    }

    return dataList;
  }

  Future<void> leaveGroupWithMeAsAnOwner(LeaveGroupWithMeAsAnOwnerRequest data) async {
    await socketCaller.emitCallV3(
      BackendPath.leaveGroupWithMeAsAnOwner.socket,
      data.toJson(),
    );
  }

  Future<GroupPermissionEntity?> fetchGroupPermissions(String roomId) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.getGroupPermission.socket,
      {'roomId': roomId},
    );

    return res.mapToResponseV3<GroupPermissionEntity>(
      (data) => GroupPermissionEntity.fromJson(data),
    );
  }

  Future<GroupPermissionEntity?> updateGroupPermissions(GroupPermissionEntity permission) async {
    final res = await socketCaller.emitCallV3(
      BackendPath.updateGroupPermission.socket,
      permission.toJson(),
    );

    return res.mapToResponseV3<GroupPermissionEntity>(
      (data) => GroupPermissionEntity.fromJson(data),
    );
  }

  Future<RichMenuModel?> fetchOaRichMenu(String accountId) async {
    final socketResp = await socketCaller.emitCallV3(
      BackendPath.getOaRichMenu.socket,
      {'officialAccountId': accountId},
    );

    return socketResp.mapToResponseV3<RichMenuModel>(
      (data) => RichMenuModel.fromJson(data),
    );
  }
}
