import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_menu_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UpdateMenuUseCase extends SimpleUseCase<RoomCollection?, RoomMenuRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<RoomCollection?> call(RoomMenuRequest params) async {
    return await chatRoomDetailServerRepository.updateMenu(params);
  }
}
