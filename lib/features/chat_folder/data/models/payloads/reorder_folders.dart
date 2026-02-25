import '../../../domain/entities/chat_folder_entity.dart';

class ReorderFoldersParams {
  final List<String> chatFolderIds;
  final List<String> delChatFolderIds;

  ReorderFoldersParams({
    required this.chatFolderIds,
    this.delChatFolderIds = const [],
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatFolderIds': chatFolderIds,
      'delChatFolderIds': delChatFolderIds,
    };
  }
}

class ReorderFoldersResponse {
  final List<ChatFolderEntity> chatFolders;

  ReorderFoldersResponse({
    required this.chatFolders,
  });

  factory ReorderFoldersResponse.fromMapV3(map) {
    final chatFolders = (map['data'] as List<dynamic>).map((e) => ChatFolderEntity.fromMap(e)).toList();

    return ReorderFoldersResponse(
      chatFolders: chatFolders,
    );
  }
}
