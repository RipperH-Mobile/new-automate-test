import 'package:uchat/features/chat_room_list/domain/entities/invite_room_entity.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class VerifyRoomInviteLinkUseCase extends SimpleUseCase<InviteRoomEntity?, String> {
  final ChatRoomListServerRepository repository;

  VerifyRoomInviteLinkUseCase({required this.repository});

  @override
  Future<InviteRoomEntity?> call(String inviteLinkToken) async {
    return repository.verifyInviteLink(inviteLinkToken);
  }
}
