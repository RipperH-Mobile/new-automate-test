import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_subscription_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SyncHandleUpdateHasFirstOtherInRoomUseCase extends SimpleUseCase<void, String> {
  final RoomSubscriptionLocalRepository roomSubscriptionLocalRepository;
  final RoomMemberLocalRepository roomMemberLocalRepository;

  SyncHandleUpdateHasFirstOtherInRoomUseCase({
    required this.roomSubscriptionLocalRepository,
    required this.roomMemberLocalRepository,
  });

  @override
  Future<void> call(String roomId) async {
    final memberCount = await roomMemberLocalRepository.countMemberByRoomId(roomId: roomId);
    RoomSubscriptionEntity? roomSub = await roomSubscriptionLocalRepository.getRoomSubscriptionByRoomId(roomId: roomId);
    if (roomSub != null) {
      roomSub = roomSub.copyWith(hasFirstOtherInRoom: memberCount > 1);
      await roomSubscriptionLocalRepository.putRoomSubscription(roomSub: roomSub, useTxn: false);
    }
  }
}
