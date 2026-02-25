import 'package:uchat/features/chat_folder/domain/entities/room_subscription_with_chat_folder_meta_entity.dart';

class AddRoomSubscriptionToChatFolderParams {
  final String chatFolderId;
  final List<String> roomSubIds;

  AddRoomSubscriptionToChatFolderParams({
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

class AddRoomSubscriptionToChatFolderResponse {
  final List<RoomSubscriptionWithChatFolderMetaEntity> chatFolders;

  AddRoomSubscriptionToChatFolderResponse({
    required this.chatFolders,
  });

  factory AddRoomSubscriptionToChatFolderResponse.fromMapV3(Map<String, dynamic> map) {
    final chatFolders = (map['data'] as List<Map<String, dynamic>>)
        .map((e) => RoomSubscriptionWithChatFolderMetaEntity.fromMap(e))
        .toList();

    return AddRoomSubscriptionToChatFolderResponse(
      chatFolders: chatFolders,
    );
  }
}
