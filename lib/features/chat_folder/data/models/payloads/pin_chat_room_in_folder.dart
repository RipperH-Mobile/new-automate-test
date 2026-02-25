import '../../../domain/entities/room_subscription_with_chat_folder_meta_entity.dart';

class PinChatRoomInFolderParams {
  final String chatFolderId;
  final bool isPinned;
  final List<String> roomSubIds;

  PinChatRoomInFolderParams({
    required this.chatFolderId,
    required this.isPinned,
    required this.roomSubIds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatFolderId': chatFolderId,
      'isPinned': isPinned,
      'roomSubIds': roomSubIds,
    };
  }
}

class PinChatRoomInFolderResponse {
  final List<RoomSubscriptionWithChatFolderMetaEntity> chatFolders;

  PinChatRoomInFolderResponse({
    required this.chatFolders,
  });

  factory PinChatRoomInFolderResponse.fromMapV3(map) {
    final chatFolders = (map['data'] as List<dynamic>).map((e) {
      return RoomSubscriptionWithChatFolderMetaEntity.fromMap(e);
    }).toList();

    return PinChatRoomInFolderResponse(
      chatFolders: chatFolders,
    );
  }
}
