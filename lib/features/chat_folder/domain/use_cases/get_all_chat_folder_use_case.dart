import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../entities/chat_folder_entity.dart';
import '../enums/chat_folder_type.dart';
import '../repositories/chat_folder_local_repository.dart';
import 'get_all_room_subscription_by_chat_folder_use_case.dart';

/// Get all ChatFolderCollection
///
/// If not found return empty list
///
/// [includeChatRoom] is optional, if true then it will find all RoomSubscriptionCollection by chatFolderId and put it into chatRooms
/// Default is true
///
/// [sortDesc] is optional, if true then it will sort by seq desc. Default is false (sort by seq asc)
///
/// [isHidden] is optional, if true then it will find all hidden chat folder. Default is false
///
/// [types] is optional, if you want to filter by type then you can pass the list of ChatFolderType
/// It can contain one or more type. If list is empty then it will find all type
/// Default is empty list
class GetAllChatFolderParams {
  final bool includeChatRoom;
  final bool sortDesc;
  final bool isHidden;
  final List<ChatFolderType> types;

  GetAllChatFolderParams({
    this.includeChatRoom = true,
    this.sortDesc = false,
    this.isHidden = false,
    this.types = const [],
  });
}

class GetAllChatFolderUseCase implements SimpleUseCase<List<ChatFolderEntity>, GetAllChatFolderParams> {
  final GetAllRoomSubscriptionByChatFolderUseCase getAllRoomSubscriptionByChatFolderUseCase;
  final ChatFolderLocalRepository chatFolderLocalRepository;

  GetAllChatFolderUseCase({
    required this.getAllRoomSubscriptionByChatFolderUseCase,
    required this.chatFolderLocalRepository,
  });

  @override
  Future<List<ChatFolderEntity>> call(GetAllChatFolderParams params) async {
    List<ChatFolderEntity> chatFolders = await chatFolderLocalRepository.getAll(
      sortDesc: params.sortDesc,
      isHidden: params.isHidden,
      types: params.types,
    );

    if (params.includeChatRoom) {
      List<ChatFolderEntity> chatFoldersWithRoom = [];

      for (final chatFolder in chatFolders) {
        // Get all room subscription by chat folder id
        final chatFolderMetas = await getAllRoomSubscriptionByChatFolderUseCase.call(
          GetAllRoomSubscriptionByChatFolderParams(
            chatFolderId: chatFolder.id,
          ),
        );

        final roomSubs = chatFolderMetas
            .map((item) {
              return item.roomSubscription;
            })
            .whereType<RoomSubscriptionCollection>()
            .toList();

        chatFoldersWithRoom.add(chatFolder.copyWith(roomSubscriptions: roomSubs));
      }

      chatFolders = chatFoldersWithRoom;
    }

    return chatFolders;
  }
}
