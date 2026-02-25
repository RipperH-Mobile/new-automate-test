import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_room_name_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ChangeRoomNameUseCase extends SimpleUseCase<void, ChangeRoomNameRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<void> call(ChangeRoomNameRequest params) {
    return chatRoomDetailServerRepository.changeRoomName(params);
  }
}
