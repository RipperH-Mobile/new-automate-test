import 'package:uchat/features/chat_room/data/models/requests/leave_group_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/params/leave_group_params.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class LeaveGroupUseCase extends SimpleUseCase<void, LeaveGroupParams> {
  final ChatRoomListServerRepository chatRoomListServerRepository;
  final ChatRoomLocalRepository chatRoomLocalRepository;
  final MessageLocalRepository messageLocalRepository;
  final RoomFileLocalRepository roomFileLocalRepository;

  LeaveGroupUseCase({
    required this.chatRoomListServerRepository,
    required this.chatRoomLocalRepository,
    required this.messageLocalRepository,
    required this.roomFileLocalRepository,
  });

  @override
  Future<void> call(LeaveGroupParams params) async {
    if (!params.isOnlyLocal) {
      await chatRoomListServerRepository.leaveGroup(LeaveGroupRequest(roomId: params.roomId));
    }

    await chatRoomLocalRepository.deleteRoom(params.roomId);
    await chatRoomLocalRepository.deleteRoomSubscriptionWithRoomId(params.roomId);
    await chatRoomLocalRepository.deleteMemberInRoom(params.roomId);
    await messageLocalRepository.deleteAllMessageInRoom(roomId: params.roomId);
    await roomFileLocalRepository.deleteAllFileInRoom(params.roomId);

    params.onRoomDeleted?.call(params.roomId);
  }
}
