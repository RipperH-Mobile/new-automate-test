import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/params/expire_all_secret_chat_with_account_id_params.dart';
import 'package:uchat/features/chat_room/domain/use_cases/expire_all_secret_chat_with_account_id_use_case.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/block_contact_request.dart';
import 'package:uchat/features/contact/domain/params/block_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class BlockContactUseCase extends SimpleUseCase<dynamic, BlockContactParams> {
  final ContactServerRepository contactServerRepository;
  final ContactLocalRepository contactLocalRepository;

  BlockContactUseCase({
    required this.contactServerRepository,
    required this.contactLocalRepository,
  });

  @override
  Future<void> call(BlockContactParams params) async {
    final contactIds = params.contactIds;
    if (contactIds.isEmpty) return;

    final contact = await contactServerRepository.blockContact(BlockContactRequest(friendAccountIds: contactIds));

    if (contact != null) {
      final updateContact = ContactCollection(
        id: contact.id,
        blocked: contact.blocked,
        blockedAt: contact.blockedAt,
      );

      await contactLocalRepository.putOrUpdateContact(updateContact.toEntity());
    } // After blocking set all secret chat with blocked friend to expired on local. All these secret chat on server will
    // be deleted.
    for (final friendAccountId in contactIds) {
      await GetIt.I.get<ExpireAllSecretChatWithAccountIdUseCase>().call(
            ExpireAllSecretChatWithAccountIdParams(
              accountId: friendAccountId,
            ),
          );
    }
  }
}
