import 'package:get_it/get_it.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room/data/models/requests/join_group_request.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class JoinGroupUseCase extends SimpleUseCase<bool?, JoinGroupRequest> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  @override
  Future<bool?> call(JoinGroupRequest params) async {
    final response = await _chatRoomListServerRepository.joinGroup(params);
    if (response == null) return false;

    bool isJoined = false;

    if (response.roomType == RoomAccessType.public && response.status == 'joined') {
      isJoined = true;
    }

    return isJoined;
  }
}
