import 'package:collection/collection.dart';
import 'package:uchat/features/chat_folder/domain/entities/chat_folder_meta_with_room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

/// Get all RoomSubscriptionCollection by chatFolderId asynchronously
/// If not found return empty list
class GetAllRoomSubscriptionByChatFolderParams {
  final String chatFolderId;
  final bool? isPinned;

  GetAllRoomSubscriptionByChatFolderParams({
    required this.chatFolderId,
    this.isPinned,
  });
}

class GetAllRoomSubscriptionByChatFolderUseCase
    implements SimpleUseCase<List<ChatFolderMetaWithRoomSubscriptionEntity>, GetAllRoomSubscriptionByChatFolderParams> {
  final ChatRoomLocalRepository chatRoomLocalRepository;

  GetAllRoomSubscriptionByChatFolderUseCase({
    required this.chatRoomLocalRepository,
  });

  @override
  Future<List<ChatFolderMetaWithRoomSubscriptionEntity>> call(
    GetAllRoomSubscriptionByChatFolderParams params,
  ) async {
    final roomSubs = await chatRoomLocalRepository.getRoomSubscriptionByChatFolder(
      chatFolderId: params.chatFolderId,
      isPinned: params.isPinned,
    );

    final List<ChatFolderMetaWithRoomSubscriptionEntity> chatFolderRoom = [];
    for (final roomSub in roomSubs) {
      final chatFolder = roomSub.chatFolders?.firstWhereOrNull(
        (element) => element.folderId == params.chatFolderId,
      );

      if (chatFolder != null) {
        chatFolderRoom.add(ChatFolderMetaWithRoomSubscriptionEntity(
          chatFolderId: params.chatFolderId,
          roomSubscription: roomSub,
          isPinned: chatFolder.isPinned,
        ));
      } else {
        chatFolderRoom.add(ChatFolderMetaWithRoomSubscriptionEntity(
          chatFolderId: params.chatFolderId,
          roomSubscription: roomSub,
          isPinned: false,
        ));
      }
    }

    return chatFolderRoom;
  }
}
