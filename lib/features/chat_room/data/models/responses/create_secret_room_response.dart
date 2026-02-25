import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/create_secret_room_response_entity.dart';

class CreateSecretRoomResponse {
  RoomCollection room;
  RoomSubscriptionCollection roomSub;
  List<RoomMemberCollection> members;

  CreateSecretRoomResponse({
    required this.room,
    required this.roomSub,
    required this.members,
  });

  static CreateSecretRoomResponse fromMap(Map<String, dynamic> data) {
    List<RoomMemberCollection> roomMembers = [];
    for (final member in data['members']) {
      roomMembers.add(RoomMemberCollection.fromMap(member));
    }

    return CreateSecretRoomResponse(
      room: RoomCollection.fromMap(data),
      roomSub: RoomSubscriptionCollection.fromMap(data['mySubscription']),
      members: roomMembers,
    );
  }

  CreateSecretRoomResponseEntity toEntity() {
    return CreateSecretRoomResponseEntity(
      room: room.toEntity(),
      roomSub: roomSub.toEntity(),
      members: members.map((m) => m.toEntity()).toList(),
    );
  }
}
