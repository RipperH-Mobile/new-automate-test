import 'package:uchat/api/api.dart';

import '../../../domain/entities/chat_folder_entity.dart';
import '../../models/payloads/add_room_subscription_to_chat_folder.dart';
import '../../models/payloads/create_chat_folder.dart';
import '../../models/payloads/delete_chat_folder.dart';
import '../../models/payloads/fetch_folders.dart';
import '../../models/payloads/pin_chat_room_in_folder.dart';
import '../../models/payloads/remove_room_subscription_from_chat_folder.dart';
import '../../models/payloads/reorder_folders.dart';
import '../../models/payloads/update_chat_folder.dart';
import 'backend_path.dart';

class ChatFolderHttpDataSource {
  final HttpCaller httpCaller;

  ChatFolderHttpDataSource({
    required this.httpCaller,
  });

  Future<CreateChatFolderResponse?> createFolder(CreateChatFolderParams params) async {
    final socketResp = await httpCaller.post(
      createFolderPath.http,
      data: params.toMap(),
    );

    return socketResp.mapToResponse((data) => CreateChatFolderResponse.fromMapV3(data));
  }

  Future<PaginationPayload<ChatFolderEntity>?> fetchFolders(FetchFoldersParams params) async {
    final socketResp = await httpCaller.get(
      fetchFoldersPath.http,
      data: params.toMap(),
    );

    return socketResp.mapToResponse((element) {
      return PaginationPayload<ChatFolderEntity>.fromMapV3(
        element,
        listMapper: (data) {
          List<ChatFolderEntity> dataList = [];

          for (final item in data) {
            dataList.add(ChatFolderEntity.fromMap(item));
          }

          return dataList;
        },
      );
    });
  }

  Future<UpdateChatFolderResponse?> updateFolder(UpdateChatFolderParams params) async {
    final socketResp = await httpCaller.put(
      updateFolderPath.http.replaceAll(':chatFolderId', params.chatFolderId),
      data: params.toMap(),
    );

    return socketResp.mapToResponse((data) => UpdateChatFolderResponse.fromMapV3OldResponse(data, params.chatFolderId));
  }

  Future<DeleteChatFolderResponse?> deleteFolder(DeleteChatFolderParams params) async {
    final socketResp = await httpCaller.delete(
      deleteFolderPath.http.replaceAll(':chatFolderId', params.chatFolderId),
      data: params.toMap(),
    );

    return socketResp.mapToResponse((data) => DeleteChatFolderResponse.fromMapV3OldResponse(data, params.chatFolderId));
  }

  Future<AddRoomSubscriptionToChatFolderResponse?> addRoomSubscriptionToChatFolder(
    AddRoomSubscriptionToChatFolderParams params,
  ) async {
    final socketResp = await httpCaller.post(
      addRoomSubscriptionToChatFolderPath.http.replaceAll(':chatFolderId', params.chatFolderId),
      data: params.toMap(),
    );

    return socketResp.mapToResponse((data) => AddRoomSubscriptionToChatFolderResponse.fromMapV3(data));
  }

  Future<RemoveRoomSubscriptionFromChatFolderResponse?> removeRoomSubscriptionFromChatFolder(
    RemoveRoomSubscriptionFromChatFolderParams params,
  ) async {
    final socketResp = await httpCaller.post(
      removeRoomSubscriptionFromChatFolderPath.http.replaceAll(':chatFolderId', params.chatFolderId),
      data: params.toMap(),
    );

    return socketResp.mapToResponse((data) => RemoveRoomSubscriptionFromChatFolderResponse.fromMapV3(data));
  }

  Future<PinChatRoomInFolderResponse?> pinChatRoomInFolder(PinChatRoomInFolderParams params) async {
    final socketResp = await httpCaller.post(
      pinChatRoomInFoldersPath.http.replaceAll(':chatFolderId', params.chatFolderId),
      data: params.toMap(),
    );

    return socketResp.mapToResponse((data) => PinChatRoomInFolderResponse.fromMapV3(data));
  }

  Future<ReorderFoldersResponse?> reorderFolders(ReorderFoldersParams params) async {
    final socketResp = await httpCaller.post(
      reorderFolderPath.socket,
      data: params.toMap(),
    );

    return socketResp.mapToResponse((data) => ReorderFoldersResponse.fromMapV3(data));
  }
}
