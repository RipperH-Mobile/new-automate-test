import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';

class MemberStateDataModel {
  String roomId;
  List<RoomMemberCollection> members;
  int? memberRequestCount;
  int? memberCount;

  MemberStateDataModel({
    required this.roomId,
    required this.members,
    this.memberRequestCount,
    this.memberCount,
  });

  factory MemberStateDataModel.fromMap(Map<String, dynamic> data) {
    List<RoomMemberCollection> members = [];
    for (final memberData in data['members']) {
      members.add(RoomMemberCollection.fromMap(memberData));
    }

    return MemberStateDataModel(
      roomId: data['_id'],
      members: members,
      memberRequestCount: data['memberRequestCount'],
      memberCount: data['membership'],
    );
  }
}
