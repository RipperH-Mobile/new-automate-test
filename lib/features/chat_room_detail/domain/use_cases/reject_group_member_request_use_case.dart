import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/reject_group_member_request.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RejectGroupMemberRequestUseCase extends SimpleUseCase<void, RejectGroupMemberRequest> {
  ChatRoomDetailServerRepository get chatRoomDetailServerRepository {
    return GetIt.I<ChatRoomDetailServerRepository>();
  }

  @override
  Future<void> call(RejectGroupMemberRequest params) {
    return chatRoomDetailServerRepository.rejectGroupMemberRequest(params);
  }
}
