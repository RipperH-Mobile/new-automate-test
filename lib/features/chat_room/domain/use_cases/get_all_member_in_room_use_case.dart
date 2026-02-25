import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllMemberInRoomUseCase extends SimpleUseCase<List<RoomMemberEntity>?, ChatRoomParams> {
  final _log = useLogger();

  final ChatRoomLocalRepository chatRoomLocalRepository;

  GetAllMemberInRoomUseCase({
    required this.chatRoomLocalRepository,
  });

  @override
  Future<List<RoomMemberEntity>> call(ChatRoomParams params) async {
    try {
      return await chatRoomLocalRepository.getAllMemberInRoom(params.roomId) ?? [];
    } catch (e, stackTrace) {
      _log.e('GetAllMemberInRoomUseCase error', e, stackTrace);
      return [];
    }
  }
}
