import '../entities/room_subscription_with_chat_folder_meta_entity.dart';

class ChatFolderUpdateRoomSubEvent {
  final List<RoomSubscriptionWithChatFolderMetaEntity> roomSubscriptions;

  ChatFolderUpdateRoomSubEvent({required this.roomSubscriptions});

  @override
  String toString() {
    return 'ChatFolderUpdateRoomSubEvent{roomSubscriptions: $roomSubscriptions}';
  }
}
