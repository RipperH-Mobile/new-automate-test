import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class PutAllContactWithoutTxnUseCase extends SimpleUseCase<void, List<ContactEntity>> {
  final ContactLocalRepository contactLocalRepository;
  
  PutAllContactWithoutTxnUseCase({
    required this.contactLocalRepository,
  });
  
  @override
  Future<void> call(List<ContactEntity> contactList) async {
    return await contactLocalRepository.putAllContactWithoutTxn(contactList);
  }
}
