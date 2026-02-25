import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

import 'chat_folder_meta_entity.dart';

class ChatFolderMetaWithRoomSubscriptionEntity extends ChatFolderMetaEntity {
  final RoomSubscriptionEntity? roomSubscription;

  ChatFolderMetaWithRoomSubscriptionEntity({
    required super.chatFolderId,
    super.isPinned = false,
    this.roomSubscription,
  });
}
