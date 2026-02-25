import 'package:uchat/api/payloads/pagination/pagination_payload.dart';

import '../../data/models/payloads/add_room_subscription_to_chat_folder.dart';
import '../../data/models/payloads/create_chat_folder.dart';
import '../../data/models/payloads/delete_chat_folder.dart';
import '../../data/models/payloads/fetch_folders.dart';
import '../../data/models/payloads/pin_chat_room_in_folder.dart';
import '../../data/models/payloads/remove_room_subscription_from_chat_folder.dart';
import '../../data/models/payloads/reorder_folders.dart';
import '../../data/models/payloads/update_chat_folder.dart';
import '../entities/chat_folder_entity.dart';

abstract class ChatFolderRemoteRepository {
  Future<CreateChatFolderResponse?> createFolder(CreateChatFolderParams params);

  Future<PaginationPayload<ChatFolderEntity>?> fetchFolders(FetchFoldersParams params);

  Future<UpdateChatFolderResponse?> updateFolder(UpdateChatFolderParams params);

  Future<DeleteChatFolderResponse?> deleteFolder(DeleteChatFolderParams params);

  Future<AddRoomSubscriptionToChatFolderResponse?> addRoomSubscriptionToChatFolder(
    AddRoomSubscriptionToChatFolderParams params,
  );

  Future<RemoveRoomSubscriptionFromChatFolderResponse?> removeRoomSubscriptionFromChatFolder(
    RemoveRoomSubscriptionFromChatFolderParams params,
  );

  Future<PinChatRoomInFolderResponse?> pinChatRoomInFolder(PinChatRoomInFolderParams params);

  Future<ReorderFoldersResponse?> reorderFolders(ReorderFoldersParams params);
}
