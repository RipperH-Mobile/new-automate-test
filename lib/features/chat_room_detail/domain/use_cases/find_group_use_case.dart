import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_request.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/find_group_response.dart';
import 'package:uchat/use_cases/use_case.dart';

class FindGroupUseCase extends SimpleUseCase<FindGroupResponse?, FindGroupRequest> {
  ChatRoomServerRepository get chatRoomServerRepository {
    return GetIt.I<ChatRoomServerRepository>();
  }

  @override
  Future<FindGroupResponse?> call(FindGroupRequest params) async {
    return await chatRoomServerRepository.findGroup(params);
  }
}
