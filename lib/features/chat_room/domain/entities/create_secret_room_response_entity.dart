import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';

class CreateSecretRoomResponseEntity {
  final RoomEntity room;
  final RoomSubscriptionEntity roomSub;
  final List<RoomMemberEntity> members;

  CreateSecretRoomResponseEntity({
    required this.room,
    required this.roomSub,
    required this.members,
  });
}
