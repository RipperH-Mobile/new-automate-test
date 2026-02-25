import '../../../domain/entities/chat_folder_entity.dart';

class UpdateChatFolderParams {
  final String chatFolderId;
  final int? seq;
  final String? name;
  final List<String>? roomSubIds;
  final List<String>? removeRoomSubIds;

  UpdateChatFolderParams({
    required this.chatFolderId,
    this.seq,
    this.name,
    this.roomSubIds,
    this.removeRoomSubIds,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'chatFolderId': chatFolderId,
    };

    if (seq != null) {
      data['seq'] = seq;
    }

    if (name != null) {
      data['name'] = name;
    }

    if (roomSubIds != null) {
      data['roomSubIds'] = roomSubIds;
    }

    if (roomSubIds != null) {
      data['removeRoomSubIds'] = removeRoomSubIds;
    }

    return data;
  }
}

class UpdateChatFolderResponse {
  final ChatFolderEntity chatFolder;

  UpdateChatFolderResponse({
    required this.chatFolder,
  });

  /// Temporary method to support old API response format
  @Deprecated('Use [fromMapV3] instead')
  factory UpdateChatFolderResponse.fromMapV3OldResponse(Map<String, dynamic> map, String chatFolderId) {
    final chatFolders = map['data'] as List<dynamic>;

    final chatFolder = ChatFolderEntity.fromMap(chatFolders.firstWhere(
      (element) => element['_id'] == chatFolderId,
    ));

    return UpdateChatFolderResponse(
      chatFolder: chatFolder,
    );
  }

  factory UpdateChatFolderResponse.fromMapV3(Map<String, dynamic> map) {
    final chatFolder = ChatFolderEntity.fromMap(map['data'] as Map<String, dynamic>);

    return UpdateChatFolderResponse(
      chatFolder: chatFolder,
    );
  }

  @override
  String toString() {
    return 'ChatFolderCreateResponse(chatFolder: $chatFolder)';
  }
}
