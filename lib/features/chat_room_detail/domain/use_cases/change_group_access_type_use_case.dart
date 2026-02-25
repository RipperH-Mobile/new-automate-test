import 'package:get_it/get_it.dart';
import 'package:uchat/entities/enum/room_access_type.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/change_group_access_type_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ChangeGroupAccessTypeUseCase extends SimpleUseCase<RoomAccessType, ChangeGroupAccessTypeRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<RoomAccessType> call(ChangeGroupAccessTypeRequest params) async {
    final result = await chatRoomDetailServerRepository.changeGroupAccessType(params);
    return result ?? params.accessType;
  }
}
