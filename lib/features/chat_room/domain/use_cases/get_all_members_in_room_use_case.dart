import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllMembersInRoomUseCase extends SimpleUseCaseSync<List<RoomMemberEntity>, String> {
  final ChatRoomLocalRepository chatRoomLocalRepository;

  GetAllMembersInRoomUseCase({required this.chatRoomLocalRepository});

  @override
  List<RoomMemberEntity> call(String roomId) {
    return chatRoomLocalRepository.getAllMembersInRoom(roomId);
  }
}
