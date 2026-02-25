import 'dart:async';

import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
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
import 'package:uchat/features/chat_room/data/models/requests/share_file_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_message_from_server_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_room_encryption_key_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/get_secret_room_encryption_key_response.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_direct_chat_response.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request.dart';
import 'package:uchat/features/chat_room/data/models/responses/open_system_chat_response.dart';
import 'package:uchat/features/chat_room/domain/entities/get_message_reaction_model.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_all_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/message_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_response.dart';

const allRoomLastSyncAtKey = 'ALL_ROOM_LAST_SEEN_LAST_SYNC';
final _log = useLogger();

class ChatRoomApiService {
  ChatRoomApiService({
    required this.httpCaller,
  });

  final HttpCaller httpCaller;

  /// Sent read time to server
  Future<void> triggerReadMessage(ReadMessageRequest request) async {
    await httpCaller.post(
      BackendPath.triggerReadMessage.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  /// ServiceMethod: Open direct chat
  /// Use this to get direct chat from server. Use [openDirectChatAndSaveToDb] if
  /// room data needed to be save into local db right away.
  /// TODO: move to room service, and use this to create direct room when click on notification
  Future<OpenDirectChatResponse?> openDirectChat(
    OpenDirectChatRequest request,
  ) async {
    final httpResp = await httpCaller.post(
      BackendPath.openDirectChat.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse<OpenDirectChatResponse>(
      (data) => OpenDirectChatResponse.fromMap(data),
    );
  }

  Future<OpenSystemChatResponse?> openSystemChat() async {
    final httpResp = await httpCaller.post(
      BackendPath.openSystemChat.http,
    );

    return httpResp.mapToResponseV3<OpenSystemChatResponse>(
      (data) => OpenSystemChatResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<RoomMemberCollection>> getMembersInRoom(
    GetRoomMembersRequest request,
  ) async {
    final httpResp = await httpCaller.get(
      BackendPath.getMembersInRoom.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );

    return PaginationPayload.fromMapV3(
      httpResp.data,
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
    final httpResp = await httpCaller.post(
      BackendPath.setLockMessagePassword.http.replaceAll(':roomId', req.roomId),
      data: req.toJson(),
    );

    return httpResp.data;
  }

  /// ServiceMethod: get chat messages
  Future<GetMessageFromServerResponse?> getMessages(
    GetMessageFromServerRequest request, {
    Duration timeout = emitCallTimeout,
  }) async {
    //NOTE.local DB ==> messageDb.getAllSentMessage shoude in impl_repo
    final httpResp = await httpCaller.get(
      BackendPath.getMessages.http.replaceAll(':roomId', request.roomId),
      queryParameters: request.toMap(),
    );
    return GetMessageFromServerResponse(
      messages: httpResp.listToResponseV3((data) => MessageCollection.fromMap(data))?.toList(),
    );
  }

  /// ServiceMethod: Send Message
  Future<SendMessageResponse?> sendMessage(
    SendMessageRequest request,
  ) async {
    final httpResp = await httpCaller.post(
      BackendPath.sendMessage.http,
      data: request.toMap(),
    );

    return SendMessageResponse.fromMap(httpResp.data);
  }

  /// ServiceMethod: Send File
  Future<void> sendFile(
    ChatSendFileRequest request,
  ) async {
    await httpCaller.post(
      BackendPath.uploadFile.http.replaceAll(':roomId', request.roomId),
      data: request,
      onSendProgress: request.onSendProgress,
      cancelToken: request.cancelToken,
    );
  }

  Future<void> uploadFilesConfirm(UploadFilesConfirmRequest request) async {
    await httpCaller.post(
      BackendPath.uploadFileConfirm.http.replaceAll(':roomId', request.roomId),
      data: request.toMap(),
    );
  }

  /// ServiceMethod: Save to bookmark
  Future<void> saveToBookmark(SaveBookmarkRequest request) async {
    await httpCaller.post(
      BackendPath.saveToBookmark.http,
      data: request.toMap(),
    );
  }

  /// ServiceMethod: Remove from bookmark
  Future<void> removeFromBookmark(RemoveBookmarkRequest request) async {
    await httpCaller.delete(
      BackendPath.removeFromBookmark.http,
      data: request.toMap(),
    );
  }

  /// ServiceMethod: Unsent Message
  Future<void> unsentMessage(UnsentMessageRequest request) async {
    await httpCaller.post(
      BackendPath.unsendMessageV3.http,
      data: {'messages': request.toListMap()},
    );
  }

  /// ServiceMethod: Unsent Message
  Future<void> removeMessage(DeleteMessageRequest request) async {
    await httpCaller.delete(
      BackendPath.removeMessageV3.http,
      data: {'messages': request.toListMap()},
    );
  }

  /// ServiceMethod: Remove Other's Message
  Future<void> removeOtherMessage(DeleteOtherMessageRequest request) async {
    await httpCaller.delete(
      BackendPath.removeOtherMessageV3.http,
      data: {
        'roomId': request.roomId,
        'messages': request.toListMap(),
      },
    );
  }

  /// ServiceMethod: Edit Message
  Future<MessageEntity?> editMessage(EditMessageRequest request) async {
    final resp = await httpCaller.put(
      BackendPath.editMessage.http.replaceAll(':messageId', request.messageId),
      data: request.toMap(),
    );
    return resp.mapToResponseV3<MessageEntity>(
      (result) => MessageEntity.fromJson(result),
    );
  }

  Future<void> shareFile(
    ShareFileRequest request,
  ) async {
    try {
      await httpCaller.post(
        BackendPath.shareFile.http,
        data: request.toJson(),
      );
    } catch (e) {
      _log.e('Send share files to server error', e);
      rethrow;
    }
  }

  Future<MessageReactionResponse?> reactMessage(ReactMessageRequest request) async {
    final res = await httpCaller.post(
      BackendPath.reactMessage.http.replaceAll(':messageId', request.msgId),
      data: request.toJson(),
    );

    return res.mapToResponseV3<MessageReactionResponse>(
      (result) => MessageReactionResponse.fromMap(result),
    );
  }

  Future<PaginationPayload<GetMessageReactionModel>?> getMessageReact(GetMessageReactRequest request) async {
    try {
      final res = await httpCaller.get(
        BackendPath.getMessageReact.http.replaceAll(':messageId', request.msgId),
        data: request.toJsonData(),
      );
      return res.mapToResponse((e) {
        return PaginationPayload<GetMessageReactionModel>.fromMapV3(
          e,
          listMapper: (data) => (data).map((item) => GetMessageReactionModel.fromJson(item)).toList(),
        );
      });
    } catch (e, stackTrace) {
      _log.e('Get message react api error.', e, stackTrace);
      rethrow;
    }
  }

  Future<PinMessageCollection?> pinMessage(PinMessageRequest request) async {
    final res = await httpCaller.post(
      BackendPath.pinMessage.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );

    return res.mapToResponseV3(
      (data) => PinMessageCollection.fromJson(data),
    );
  }

  Future<void> unpinMessage(UnpinMessageRequest request) async {
    await httpCaller.post(
      BackendPath.unpinMessage.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  Future<void> unpinAllMessages(UnpinAllMessagesRequest request) async {
    await httpCaller.post(
      BackendPath.unpinAllMessages.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );
  }

  Future<PaginationPayload<PinMessageCollection>?> getPinMessages(GetPinMessagesRequest request) async {
    final res = await httpCaller.get(
      BackendPath.getPinMessages.http.replaceAll(':roomId', request.roomId),
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
    await httpCaller.post(
      BackendPath.openSupportTicket.http,
      data: request.toJson(),
    );
  }

  Future<GetSecretRoomEncryptionKeyResponse?> getSecretRoomEncryptionKey(
    GetSecretRoomEncryptionKeyRequest request,
  ) async {
    final httpResp = await httpCaller.get(
      BackendPath.getEncryptionKey.http.replaceAll(':roomId', request.roomId),
    );

    return httpResp.mapToResponse(
      (data) => GetSecretRoomEncryptionKeyResponse.fromMap(data),
    );
  }

  /// Get public key of the requested room.
  /// If the requested room doesn't have public key, The value in response will be '{}'
  Future<GetRoomEncryptionKeyResponse?> getRoomEncryptionKey(GetRoomEncryptionKeyRequest request) async {
    final httpResp = await httpCaller.get(
      BackendPath.getRoomEncryptionKey.http.replaceAll(':roomId', request.roomId),
      data: request.toJson(),
    );

    return httpResp.mapToResponse<GetRoomEncryptionKeyResponse>(
      (data) => GetRoomEncryptionKeyResponse.fromMap(data),
    );
  }

  Future<bool?> notifyCaptureScreenInSecretChat(String roomId) async {
    final httpResp = await httpCaller.post(
      BackendPath.notifyCaptureScreenInSecretChat.http.replaceAll(':roomId', roomId),
    );

    return httpResp.data;
  }

  Future<RoomCollection?> getDraftMenu(String roomId) async {
    final httpResp = await httpCaller.get(
      BackendPath.getDraftMenu.http,
      data: {'roomId': roomId},
    );

    return httpResp.mapToResponse<RoomCollection>(
      (data) => RoomCollection.fromMap(data),
    );
  }

  Future<void> resetCallStatus() async {
    await httpCaller.post(BackendPath.resetCallStatus.http);
  }

  Future<bool> isCallStillAvailable(String roomId) async {
    final httpResp = await httpCaller.post(
      BackendPath.isCallStillAvailable.http.replaceAll(':roomId', roomId),
    );

    return httpResp.data;
  }

  Future<bool> checkIsOwner() async {
    final httpResp = await httpCaller.get(
      BackendPath.checkIsOwner.http,
    );

    return httpResp.data['data']['hasOwnerRoom'];
  }

  Future<FindGroupResponse?> findGroup(FindGroupRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.findGroup.http,
      data: request.toJson(),
    );

    return httpResp.mapToResponse((data) => FindGroupResponse.fromJson(data));
  }

  Future<List<RoomCollection>?> getAllGroupRoomOwnByMe() async {
    final httpResp = await httpCaller.get(
      BackendPath.getRoomOwnByMe.socket,
      data: {
        'isIgnoreOnlyMe': true,
      },
    );

    List<RoomCollection> dataList = [];
    final rows = httpResp.data['rows'];

    for (final row in rows) {
      dataList.add(RoomCollection.fromMap(row));
    }

    return dataList;
  }

  Future<void> leaveGroupWithMeAsAnOwner(LeaveGroupWithMeAsAnOwnerRequest data) async {
    await httpCaller.post(
      BackendPath.leaveGroupWithMeAsAnOwner.http,
      data: data.toJson(),
    );
  }

  Future<GroupPermissionEntity?> fetchGroupPermissions(String roomId) async {
    final resp = await httpCaller.get(
      BackendPath.getGroupPermission.http.replaceAll(':roomId', roomId),
    );

    return resp.mapToResponseV3<GroupPermissionEntity>(
      (data) => GroupPermissionEntity.fromJson(data),
    );
  }

  Future<GroupPermissionEntity?> updateGroupPermissions(GroupPermissionEntity permission) async {
    final resp = await httpCaller.put(
      BackendPath.updateGroupPermission.http.replaceAll(':roomId', permission.roomId),
      data: permission.toJson(),
    );

    return resp.mapToResponseV3<GroupPermissionEntity>(
      (data) => GroupPermissionEntity.fromJson(data),
    );
  }

  Future<RichMenuModel?> fetchOaRichMenu(String officialAccountId) async {
    final httpResp = await httpCaller.get(
      BackendPath.getOaRichMenu.http.replaceAll(':officialAccountId', officialAccountId),
    );

    return httpResp.mapToResponseV3<RichMenuModel>(
      (data) => RichMenuModel.fromJson(data),
    );
  }
}
