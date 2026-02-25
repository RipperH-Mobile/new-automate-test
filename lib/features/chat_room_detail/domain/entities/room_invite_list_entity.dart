import 'package:uchat/features/chat_room_detail/domain/entities/room_invite_entity.dart';

class RoomInviteListEntity {
  final List<RoomInviteEntity>? rooms;
  final int? roomsCount;

  RoomInviteListEntity({
    this.rooms,
    this.roomsCount,
  });
}
