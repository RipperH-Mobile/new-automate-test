import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/find_group_entity.dart';

class FindGroupResponse {
  final RoomCollection room;
  final List<RoomMemberCollection> members;

  FindGroupResponse({
    required this.room,
    required this.members,
  });

  factory FindGroupResponse.fromJson(Map<String, dynamic> data) {
    List<RoomMemberCollection> members = [];
    for (final memberData in data['members']) {
      members.add(RoomMemberCollection.fromMap(memberData));
    }

    return FindGroupResponse(
      room: RoomCollection.fromMap(data),
      members: members,
    );
  }

  FindGroupEntity toEntity() {
    return FindGroupEntity(
      room: room.toEntity(),
      members: members.map((e) => e.toEntity()).toList(),
    );
  }
}
