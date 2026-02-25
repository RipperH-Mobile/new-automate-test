import 'package:uchat/features/contact/domain/params/put_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class PutContactUseCase extends SimpleUseCase<void, PutContactParams> {
  final ContactLocalRepository contactLocalRepository;
  
  PutContactUseCase({
    required this.contactLocalRepository,
  });

  @override
  Future<void> call(PutContactParams params) async {
    await contactLocalRepository.putContact(params.contact);
  }
}
