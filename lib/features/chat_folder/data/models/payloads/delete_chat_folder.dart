import '../../../domain/entities/chat_folder_entity.dart';

class DeleteChatFolderParams {
  final String chatFolderId;

  DeleteChatFolderParams({
    required this.chatFolderId,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'chatFolderId': chatFolderId,
    };

    return data;
  }
}

class DeleteChatFolderResponse {
  final ChatFolderEntity chatFolder;

  DeleteChatFolderResponse({
    required this.chatFolder,
  });

  /// Temporary method to support old API response format
  @Deprecated('Use [fromMapV3] instead')
  factory DeleteChatFolderResponse.fromMapV3OldResponse(Map<String, dynamic> map, String chatFolderId) {
    final chatFolders = map['data'] as List<Map<String, dynamic>>;

    final chatFolder = ChatFolderEntity.fromMap(chatFolders.firstWhere(
      (element) => element['_id'] == chatFolderId,
    ));

    return DeleteChatFolderResponse(
      chatFolder: chatFolder,
    );
  }

  factory DeleteChatFolderResponse.fromMapV3(Map<String, dynamic> map) {
    final chatFolder = ChatFolderEntity.fromMap(map['data'] as Map<String, dynamic>);

    return DeleteChatFolderResponse(
      chatFolder: chatFolder,
    );
  }

  @override
  String toString() {
    return 'ChatFolderCreateResponse(chatFolder: $chatFolder)';
  }
}
