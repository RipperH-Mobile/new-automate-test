

class ChatFolderMetaEntity {
  final String chatFolderId;
  final bool isPinned;

  ChatFolderMetaEntity({
    required this.chatFolderId,
    this.isPinned = false,
  });

  factory ChatFolderMetaEntity.fromMap(Map<String, dynamic> map) {
    return ChatFolderMetaEntity(
      chatFolderId: map['chatFolderId'] as String,
      isPinned: map['isPinned'] as bool? ?? false,
    );
  }
}
