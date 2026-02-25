import '../../../domain/entities/room_subscription_with_chat_folder_meta_entity.dart';

class RemoveRoomSubscriptionFromChatFolderParams {
  final String chatFolderId;
  final List<String> roomSubIds;

  RemoveRoomSubscriptionFromChatFolderParams({
    required this.chatFolderId,
    required this.roomSubIds,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'chatFolderId': chatFolderId,
      'roomSubIds': roomSubIds,
    };

    return data;
  }
}

class RemoveRoomSubscriptionFromChatFolderResponse {
  final List<RoomSubscriptionWithChatFolderMetaEntity> chatFolders;

  RemoveRoomSubscriptionFromChatFolderResponse({
    required this.chatFolders,
  });

  factory RemoveRoomSubscriptionFromChatFolderResponse.fromMapV3(Map<String, dynamic> map) {
    final chatFolders = (map['data'] as List<Map<String, dynamic>>)
        .map((e) => RoomSubscriptionWithChatFolderMetaEntity.fromMap(e))
        .toList();

    return RemoveRoomSubscriptionFromChatFolderResponse(
      chatFolders: chatFolders,
    );
  }
}
