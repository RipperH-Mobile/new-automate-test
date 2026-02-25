import 'package:uchat/use_cases/use_case.dart';

import '../entities/room_entity.dart';
import '../repositories/chat_room_local_repository.dart';

class GetGroupsWithMeAsAnOwnerUseCase extends SimpleUseCase<List<RoomEntity>?, NoParams> {
  final ChatRoomLocalRepository chatRoomLocalRepository;

  GetGroupsWithMeAsAnOwnerUseCase({
    required this.chatRoomLocalRepository,
  });

  @override
  Future<List<RoomEntity>?> call(NoParams params) async {
    return await chatRoomLocalRepository.getGroupsWithMeAsAnOwner();
  }
}
