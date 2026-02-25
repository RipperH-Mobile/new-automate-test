import '../../../domain/entities/chat_folder_entity.dart';
import '../../../domain/enums/chat_folder_type.dart';

class CreateChatFolderParams {
  final String name;
  final ChatFolderType type;
  final List<String> roomSubIds;

  CreateChatFolderParams({
    required this.name,
    required this.type,
    required this.roomSubIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type.value,
      'roomSubIds': roomSubIds,
    };
  }
}

class CreateChatFolderResponse {
  final ChatFolderEntity chatFolder;

  CreateChatFolderResponse({
    required this.chatFolder,
  });

  factory CreateChatFolderResponse.fromMapV3(Map<String, dynamic> map) {
    final chatFolder = ChatFolderEntity.fromMap(map['data'] as Map<String, dynamic>);

    return CreateChatFolderResponse(
      chatFolder: chatFolder,
    );
  }

  @override
  String toString() {
    return 'ChatFolderCreateResponse(chatFolder: $chatFolder)';
  }
}
