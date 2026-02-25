import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/create_group_chat_response_entity.dart';

class CreateGroupChatResponseModel {
  final RoomCollection room;

  CreateGroupChatResponseModel({
    required this.room,
  });

  static CreateGroupChatResponseModel fromMap(Map<String, dynamic> data) {
    return CreateGroupChatResponseModel(
      room: RoomCollection.fromMap(data),
    );
  }

  CreateGroupChatResponseModel.fromEntity(CreateGroupChatResponseEntity entity) : room = entity.room;

  CreateGroupChatResponseEntity toEntity() {
    return CreateGroupChatResponseEntity(
      room: room,
    );
  }
}
