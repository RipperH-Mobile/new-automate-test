import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllGroupRoomOwnByMeUseCase extends SimpleUseCase<List<RoomEntity>?, NoParams> {
  final ChatRoomServerRepository chatRoomServerRepository;

  GetAllGroupRoomOwnByMeUseCase({
    required this.chatRoomServerRepository,
  });

  @override
  Future<List<RoomEntity>?> call(NoParams params) async {
    return await chatRoomServerRepository.getAllGroupRoomOwnByMe();
  }
}
