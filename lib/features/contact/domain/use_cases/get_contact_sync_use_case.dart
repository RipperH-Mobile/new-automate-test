import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetContactSyncUseCase extends SimpleUseCaseSync<ContactEntity?, String> {
  final ContactLocalRepository contactLocalRepository;

  GetContactSyncUseCase({
    required this.contactLocalRepository,
  });

  @override
  ContactEntity? call(String id) {
    return contactLocalRepository.getContactSync(id);
  }
}
