import 'package:uchat/features/chat_room/domain/entities/room_subscription_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomSubscriptionUseCase extends SimpleUseCase<RoomSubscriptionEntity?, ChatRoomParams> {
  final ChatRoomLocalRepository chatRoomLocalRepository;

  GetRoomSubscriptionUseCase({
    required this.chatRoomLocalRepository,
  });

  @override
  Future<RoomSubscriptionEntity?> call(ChatRoomParams params) async {
    String roomId = params.roomId;
    return chatRoomLocalRepository.getRoomSubscription(roomId);
  }
}
