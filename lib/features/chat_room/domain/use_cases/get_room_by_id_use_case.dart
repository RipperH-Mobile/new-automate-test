import 'package:uchat/features/chat_room/domain/entities/room_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomByIdUseCase extends SimpleUseCase<RoomEntity?, ChatRoomParams> {
  final ChatRoomLocalCompatRepository chatRoomLocalRepository;
  
  GetRoomByIdUseCase({
    required this.chatRoomLocalRepository,
  });

  @override
  Future<RoomEntity?> call(ChatRoomParams params) async {
    final roomId = params.roomId;
    return await chatRoomLocalRepository.getRoom(roomId);
  }
}
