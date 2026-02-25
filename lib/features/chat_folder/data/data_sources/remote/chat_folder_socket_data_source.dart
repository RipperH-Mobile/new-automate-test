import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/api/socket/socket_caller.dart';

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

class ChatFolderSocketDataSource {
  final SocketCaller socketCaller;

  ChatFolderSocketDataSource({
    required this.socketCaller,
  });

  Future<CreateChatFolderResponse?> createFolder(CreateChatFolderParams params) async {
    final socketResp = await socketCaller.emitCallV3(
      createFolderPath.socket,
      params.toMap(),
    );

    return socketResp.mapToResponse((data) => CreateChatFolderResponse.fromMapV3(data));
  }

  Future<PaginationPayload<ChatFolderEntity>?> fetchFolders(FetchFoldersParams params) async {
    final socketResp = await socketCaller.emitCallV3(
      fetchFoldersPath.socket,
      params.toMap(),
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
    final socketResp = await socketCaller.emitCallV3(
      updateFolderPath.socket,
      params.toMap(),
    );

    // print('ZZZ => ${socketResp.data}');

    return socketResp.mapToResponse((data) {
      // print('ZZZ => ${data.runtimeType}');
      return UpdateChatFolderResponse.fromMapV3OldResponse(data, params.chatFolderId);
    });
  }

  Future<DeleteChatFolderResponse?> deleteFolder(DeleteChatFolderParams params) async {
    final socketResp = await socketCaller.emitCallV3(
      deleteFolderPath.socket,
      params.toMap(),
    );

    return socketResp.mapToResponse((data) => DeleteChatFolderResponse.fromMapV3OldResponse(data, params.chatFolderId));
  }

  Future<AddRoomSubscriptionToChatFolderResponse?> addRoomSubscriptionToChatFolder(
    AddRoomSubscriptionToChatFolderParams params,
  ) async {
    final socketResp = await socketCaller.emitCallV3(
      addRoomSubscriptionToChatFolderPath.socket,
      params.toMap(),
    );

    return socketResp.mapToResponse((data) => AddRoomSubscriptionToChatFolderResponse.fromMapV3(data));
  }

  Future<RemoveRoomSubscriptionFromChatFolderResponse?> removeRoomSubscriptionFromChatFolder(
    RemoveRoomSubscriptionFromChatFolderParams params,
  ) async {
    final socketResp = await socketCaller.emitCallV3(
      removeRoomSubscriptionFromChatFolderPath.socket,
      params.toMap(),
    );

    return socketResp.mapToResponse((data) => RemoveRoomSubscriptionFromChatFolderResponse.fromMapV3(data));
  }

  Future<PinChatRoomInFolderResponse?> pinChatRoomInFolder(PinChatRoomInFolderParams params) async {
    final socketResp = await socketCaller.emitCallV3(
      pinChatRoomInFoldersPath.socket,
      params.toMap(),
    );

    return socketResp.mapToResponse((data) => PinChatRoomInFolderResponse.fromMapV3(data));
  }

  Future<ReorderFoldersResponse?> reorderFolders(ReorderFoldersParams params) async {
    final socketResp = await socketCaller.emitCallV3(
      reorderFolderPath.socket,
      params.toMap(),
    );

    return socketResp.mapToResponse((data) => ReorderFoldersResponse.fromMapV3(data));
  }
}
