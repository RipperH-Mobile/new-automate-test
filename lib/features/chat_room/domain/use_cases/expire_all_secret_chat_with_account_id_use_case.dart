import 'package:uchat/features/chat_room/domain/params/expire_all_secret_chat_with_account_id_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_member_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ExpireAllSecretChatWithAccountIdUseCase extends SimpleUseCase<void, ExpireAllSecretChatWithAccountIdParams> {
  final RoomMemberLocalRepository roomMemberLocalRepository;
  final ChatRoomLocalCompatRepository chatRoomLocalRepository;

  ExpireAllSecretChatWithAccountIdUseCase({
    required this.roomMemberLocalRepository,
    required this.chatRoomLocalRepository,
  });

  @override
  Future<void> call(ExpireAllSecretChatWithAccountIdParams params) async {
    final members = await roomMemberLocalRepository.getMemberWithIdInSecretChat(params.accountId);
    for (final member in members) {
      final blockedFriendRoomId = member.roomId;

      final secretRoom = await chatRoomLocalRepository.getRoom(blockedFriendRoomId);

      if (secretRoom != null) {
        // Set expire at to somewhere in the past to make secret chat expired.
        final updateExpireRoom = secretRoom.copyWith(
          expireAt: DateTime(1998),
        );
        // Update secret room
        await chatRoomLocalRepository.putOrUpdateRoom(updateExpireRoom);
      }
    }
  }
}
