import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class PutContactWithoutTxnUseCase extends SimpleUseCase<ContactEntity?, ContactEntity> {
  final ContactLocalRepository contactLocalRepository;
  
  PutContactWithoutTxnUseCase({
    required this.contactLocalRepository,
  });
  
  @override
  Future<ContactEntity?> call(ContactEntity contact) async {
    return await contactLocalRepository.putContactWithoutTxn(contact);
  }
}
