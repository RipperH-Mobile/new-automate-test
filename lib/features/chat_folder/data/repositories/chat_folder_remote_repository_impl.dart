import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/core/exceptions/api_exception.dart';

import '../../domain/entities/chat_folder_entity.dart';
import '../../domain/repositories/chat_folder_remote_repository.dart';
import '../data_sources/remote/chat_folder_http_data_source.dart';
import '../data_sources/remote/chat_folder_socket_data_source.dart';
import '../models/payloads/add_room_subscription_to_chat_folder.dart';
import '../models/payloads/create_chat_folder.dart';
import '../models/payloads/delete_chat_folder.dart';
import '../models/payloads/fetch_folders.dart';
import '../models/payloads/pin_chat_room_in_folder.dart';
import '../models/payloads/remove_room_subscription_from_chat_folder.dart';
import '../models/payloads/reorder_folders.dart';
import '../models/payloads/update_chat_folder.dart';

class ChatFolderRemoteRepositoryImpl implements ChatFolderRemoteRepository {
  final ChatFolderHttpDataSource httpDataSource;
  final ChatFolderSocketDataSource socketDataSource;

  ChatFolderRemoteRepositoryImpl({
    required this.httpDataSource,
    required this.socketDataSource,
  });

  @override
  Future<AddRoomSubscriptionToChatFolderResponse?> addRoomSubscriptionToChatFolder(
    AddRoomSubscriptionToChatFolderParams params,
  ) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.addRoomSubscriptionToChatFolder(params);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return httpDataSource.addRoomSubscriptionToChatFolder(params);
  }

  @override
  Future<CreateChatFolderResponse?> createFolder(CreateChatFolderParams params) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.createFolder(params);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return httpDataSource.createFolder(params);
  }

  @override
  Future<DeleteChatFolderResponse?> deleteFolder(DeleteChatFolderParams params) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.deleteFolder(params);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return httpDataSource.deleteFolder(params);
  }

  @override
  Future<PaginationPayload<ChatFolderEntity>?> fetchFolders(FetchFoldersParams params) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.fetchFolders(params);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return httpDataSource.fetchFolders(params);
  }

  @override
  Future<PinChatRoomInFolderResponse?> pinChatRoomInFolder(PinChatRoomInFolderParams params) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.pinChatRoomInFolder(params);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return httpDataSource.pinChatRoomInFolder(params);
  }

  @override
  Future<RemoveRoomSubscriptionFromChatFolderResponse?> removeRoomSubscriptionFromChatFolder(
    RemoveRoomSubscriptionFromChatFolderParams params,
  ) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.removeRoomSubscriptionFromChatFolder(params);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return httpDataSource.removeRoomSubscriptionFromChatFolder(params);
  }

  @override
  Future<ReorderFoldersResponse?> reorderFolders(ReorderFoldersParams params) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.reorderFolders(params);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return httpDataSource.reorderFolders(params);
  }

  @override
  Future<UpdateChatFolderResponse?> updateFolder(UpdateChatFolderParams params) {
    if (socketDataSource.socketCaller.isReadyForCall) {
      try {
        return socketDataSource.updateFolder(params);
      } on ApiException catch (e) {
        final code = e.code;
        if (code != null && code >= 400 && code < 600) {
          rethrow;
        }
      } catch (e) {
        // Handle other exceptions if needed
      }
    }

    return httpDataSource.updateFolder(params);
  }
}
