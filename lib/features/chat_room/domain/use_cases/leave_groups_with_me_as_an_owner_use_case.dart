import 'package:uchat/features/chat_room/data/models/requests/leave_group_with_me_as_an_owner_request.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../repositories/chat_room_server_repository.dart';

class LeaveGroupsWithMeAsAnOwnerUseCase extends SimpleUseCase<void, LeaveGroupWithMeAsAnOwnerRequest> {
  final ChatRoomServerRepository chatRoomServerRepository;

  LeaveGroupsWithMeAsAnOwnerUseCase({
    required this.chatRoomServerRepository,
  });

  @override
  Future<void> call(LeaveGroupWithMeAsAnOwnerRequest data) async {
    await chatRoomServerRepository.leaveGroupWithMeAsAnOwner(data);
  }
}
