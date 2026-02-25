import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';

class InitStateRoomsRequest {
  int page;
  int pageSize;

  InitStateRoomsRequest({
    required this.page,
    this.pageSize = 20,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'pageSize': pageSize,
    };
  }
}

class InitStateRoomsResponse {
  final RoomCollection room;
  final RoomSubscriptionCollection roomSub;
  final GroupPermissionEntity? groupPermission;
  final List<RoomMemberCollection>? members;

  InitStateRoomsResponse({
    required this.room,
    required this.roomSub,
    this.groupPermission,
    this.members,
  });

  factory InitStateRoomsResponse.fromMap(Map<String, dynamic> json) {
    return InitStateRoomsResponse(
      room: RoomCollection.fromMap(json),
      roomSub: RoomSubscriptionCollection.fromMap(json['mySubscription']),
      groupPermission: json['permissions'] != null ? GroupPermissionEntity.fromJson(json) : null,
      members: json['members'] != null
          ? (json['members'] as List).map((e) => RoomMemberCollection.fromMap(e)).toList()
          : null,
    );
  }
}
