import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetFriendContactByIdSyncUseCase extends SimpleUseCaseSync<ContactEntity?, ContactParams> {
  final ContactLocalRepository contactLocalRepository;

  GetFriendContactByIdSyncUseCase({
    required this.contactLocalRepository,
  });
  
  @override
  ContactEntity? call(ContactParams params) {
    return contactLocalRepository.getFriendContactByIdSync(params.accountId);
  }
}
