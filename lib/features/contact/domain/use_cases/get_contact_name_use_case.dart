import 'package:uchat/features/chat_room/data/models/responses/get_account_from_member_response.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/contact/domain/params/get_contact_name_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetContactNameUseCase extends SimpleUseCaseSync<String?, ContactNameParams> {
  final ContactLocalRepository contactLocalRepository;
  final ChatRoomLocalRepository chatRoomLocalRepository;

  GetContactNameUseCase({
    required this.contactLocalRepository,
    required this.chatRoomLocalRepository,
  });

  @override
  String? call(ContactNameParams params) {
    final contact = contactLocalRepository.getContactSync(params.accountId);
    final contactName = params.isShowFullName ? contact?.name : contact?.shortName;

    if (contactName != null) return contactName;

    final roomMember = chatRoomLocalRepository.getOneMemberInRoomSync(GetAccountFromMemberRequest(
      roomId: params.roomId,
      accountId: params.accountId,
    ));

    return params.isShowFullName ? roomMember?.account.name : roomMember?.account.shortName;
  }
}
