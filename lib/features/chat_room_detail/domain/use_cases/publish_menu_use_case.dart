import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/public_menu_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class PublishMenuUseCase extends SimpleUseCase<RoomCollection?, PublicMenuRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<RoomCollection?> call(PublicMenuRequest params) {
    return chatRoomDetailServerRepository.publishMenu(params);
  }
}
