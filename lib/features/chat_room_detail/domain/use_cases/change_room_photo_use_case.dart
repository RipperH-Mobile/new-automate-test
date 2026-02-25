import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/requests/change_room_photo_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ChangeRoomPhotoUseCase extends SimpleUseCase<void, ChangeRoomPhotoRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<void> call(ChangeRoomPhotoRequest params) {
    return chatRoomDetailServerRepository.changeRoomPhoto(params);
  }
}
