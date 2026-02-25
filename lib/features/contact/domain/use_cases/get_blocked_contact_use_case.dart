import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetBlockedContactUseCase extends SimpleUseCase<List<ContactEntity>, NoParams> {
  final ContactLocalRepository contactLocalRepository;

  GetBlockedContactUseCase({
    required this.contactLocalRepository,
  });

  @override
  Future<List<ContactEntity>> call(NoParams params) async {
    return await contactLocalRepository.getBlockedContact();
  }
}
