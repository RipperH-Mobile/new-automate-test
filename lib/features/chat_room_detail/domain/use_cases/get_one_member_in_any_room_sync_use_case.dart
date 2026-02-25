import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/entities/room_member_entity.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/get_one_member_in_any_room_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetOneMemberInAnyRoomSyncUseCase extends SimpleUseCaseSync<RoomMemberEntity?, GetOneMemberInAnyRoomRequest> {
  ChatRoomDetailLocalRepository get chatRoomDetailLocalRepository {
    return GetIt.I<ChatRoomDetailLocalRepository>();
  }

  @override
  RoomMemberEntity? call(GetOneMemberInAnyRoomRequest params) {
    return chatRoomDetailLocalRepository.getOneMemberInAnyRoomSync(GetOneMemberInAnyRoomRequest(
      accountId: params.accountId,
    ));
  }
}
