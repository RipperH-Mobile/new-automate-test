import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_list/data/models/read_all_request.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ReadAllRoomUseCase extends SimpleUseCase<dynamic, ReadAllRequest> {
  ChatRoomListServerRepository get _chatRoomListServerRepository {
    return GetIt.I<ChatRoomListServerRepository>();
  }

  @override
  Future<void> call(ReadAllRequest params) async {
    return await _chatRoomListServerRepository.readAllRoom(params);
  }
}
