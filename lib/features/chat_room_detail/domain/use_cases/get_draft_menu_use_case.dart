import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/models/room_menu_model.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/params/get_draft_menu_params.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetDraftMenuUseCase extends SimpleUseCase<RoomMenuModel?, GetDraftMenuParams> {
  ChatRoomServerRepository get chatRoomServerRepository {
    return GetIt.I<ChatRoomServerRepository>();
  }

  @override
  Future<RoomMenuModel?> call(GetDraftMenuParams params) async {
    return await chatRoomServerRepository.getDraftMenu(params.roomId);
  }
}
