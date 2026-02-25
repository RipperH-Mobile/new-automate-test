import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../entities/chat_folder_entity.dart';
import '../repositories/chat_folder_local_repository.dart';
import 'get_all_room_subscription_by_chat_folder_use_case.dart';

/// Get ChatFolderCollection by id
///
/// If not found return null
///
/// [id] is required, this is the id of ChatFolderCollection
class GetChatFolderByIdParams {
  final String chatFolderId;
  final bool includeChatRoom;

  GetChatFolderByIdParams({
    required this.chatFolderId,
    this.includeChatRoom = true,
  });
}

class GetChatFolderByIdUseCase implements SimpleUseCase<ChatFolderEntity?, GetChatFolderByIdParams> {
  final GetAllRoomSubscriptionByChatFolderUseCase getAllRoomSubscriptionByChatFolderUseCase;
  final ChatFolderLocalRepository chatFolderLocalRepository;

  GetChatFolderByIdUseCase({
    required this.getAllRoomSubscriptionByChatFolderUseCase,
    required this.chatFolderLocalRepository,
  });

  @override
  Future<ChatFolderEntity?> call(GetChatFolderByIdParams params) async {
    ChatFolderEntity? chatFolder = await chatFolderLocalRepository.getById(id: params.chatFolderId);

    if (params.includeChatRoom) {
      // Get all room subscription by chat folder id
      final chatFolderMetas = await getAllRoomSubscriptionByChatFolderUseCase.call(
        GetAllRoomSubscriptionByChatFolderParams(
          chatFolderId: params.chatFolderId,
        ),
      );

      final roomSubs = chatFolderMetas
          .map((item) {
            return item.roomSubscription;
          })
          .whereType<RoomSubscriptionCollection>()
          .toList();

      chatFolder = chatFolder?.copyWith(
        roomSubscriptions: roomSubs,
      );
    }

    return chatFolder;
  }
}
