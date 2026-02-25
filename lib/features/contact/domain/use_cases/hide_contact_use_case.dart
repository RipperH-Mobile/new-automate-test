import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/contact/data/models/mapper/contact_mapper_extensions.dart';
import 'package:uchat/features/contact/data/models/requests/hide_contact_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class HideContactUseCase extends SimpleUseCase<void, HideContactRequest> {
  final ContactServerRepository contactServerRepository;
  final ContactLocalRepository contactLocalRepository;

  HideContactUseCase({
    required this.contactServerRepository,
    required this.contactLocalRepository,
  });

  @override
  Future<void> call(HideContactRequest params) async {
    final contact = await contactServerRepository.hideContact(params);

    if (contact != null) {
      final updateContact = ContactCollection(
        id: contact.id,
        hidden: contact.hidden,
        hiddenAt: contact.hiddenAt,
      );

      await contactLocalRepository.putOrUpdateContact(updateContact.toEntity());
    }
  }
}
