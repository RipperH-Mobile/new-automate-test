import 'package:uchat/features/chat_room_detail/data/models/models/room_invite_model.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_list_entity.dart';

class RoomInviteListResponse {
  final List<RoomInviteModel>? rooms;
  final int? roomsCount;

  RoomInviteListResponse({
    this.rooms,
    this.roomsCount,
  });

  factory RoomInviteListResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> roomRows = json['rows'];
    List<RoomInviteModel> rooms = [];

    for (var room in roomRows) {
      rooms.add(RoomInviteModel.fromMap(room));
    }

    return RoomInviteListResponse(
      rooms: rooms,
      roomsCount: json['roomRequestCount'],
    );
  }

  RoomInviteListEntity toEntity() {
    return RoomInviteListEntity(
      rooms: rooms?.map((e) => e.toEntity()).toList(),
      roomsCount: roomsCount,
    );
  }
}
