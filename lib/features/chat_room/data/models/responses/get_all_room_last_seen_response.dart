import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/get_all_room_last_seen_entity.dart';

class GetAllRoomLastSeenResponse {
  String roomId;
  List<RoomMemberCollection> members;

  GetAllRoomLastSeenResponse({
    required this.roomId,
    required this.members,
  });

  static GetAllRoomLastSeenResponse fromMap(Map<String, dynamic> json) {
    List<RoomMemberCollection> members = [];
    for (final data in json['members']) {
      final member = RoomMemberCollection.fromMap(data);
      member.roomId = json['_id'];
      members.add(member);
    }
    return GetAllRoomLastSeenResponse(
      roomId: json['_id'],
      members: members,
    );
  }

  GetAllRoomLastSeenEntity toEntity() {
    return GetAllRoomLastSeenEntity(
      roomId: roomId,
      members: members.map((member) => member.toEntity()).toList(),
    );
  }
}
