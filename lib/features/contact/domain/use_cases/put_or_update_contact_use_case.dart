import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/update_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class PutOrUpdateContactUseCase extends SimpleUseCase<ContactEntity?, UpdateContactParams> {
  final ContactLocalRepository contactLocalRepository;
  
  PutOrUpdateContactUseCase({
    required this.contactLocalRepository,
  });

  @override
  Future<ContactEntity?> call(UpdateContactParams params) async {
    return await contactLocalRepository.putOrUpdateContact(params.contact);
  }
}
