import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FetchDefaultGroupAvatarUseCase extends SimpleUseCase<dynamic, NoParams> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  @override
  Future<List<String>> call(NoParams params) async {
    return await _chatRoomListServerRepository.fetchDefaultGroupAvatar();
  }
}
