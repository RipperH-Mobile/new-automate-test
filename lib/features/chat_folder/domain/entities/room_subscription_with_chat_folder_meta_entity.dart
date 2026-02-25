import 'chat_folder_meta_entity.dart';

class RoomSubscriptionWithChatFolderMetaEntity {
  /// The room subscription ID
  final String roomSubscriptionId;
  final List<ChatFolderMetaEntity> chatFolderInRoomSubscriptions;

  RoomSubscriptionWithChatFolderMetaEntity({
    required this.roomSubscriptionId,
    required this.chatFolderInRoomSubscriptions,
  });

  factory RoomSubscriptionWithChatFolderMetaEntity.fromMap(Map<String, dynamic> map) {
    // Handle null or missing chatFolders field
    // Reference: UCHAT3-27697
    final chatFoldersRaw = map['chatFolders'];
    final chatFolders = chatFoldersRaw is List
        ? chatFoldersRaw.map((e) => ChatFolderMetaEntity.fromMap(e as Map<String, dynamic>)).toList()
        : <ChatFolderMetaEntity>[];

    return RoomSubscriptionWithChatFolderMetaEntity(
      roomSubscriptionId: map['_id'] as String,
      chatFolderInRoomSubscriptions: chatFolders,
    );
  }
}
