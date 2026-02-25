import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetFriendContactByIdUseCase extends SimpleUseCase<ContactEntity?, ContactParams> {
  final ContactLocalRepository contactLocalRepository;

  GetFriendContactByIdUseCase({
    required this.contactLocalRepository,
  });

  @override
  Future<ContactEntity?> call(ContactParams params) async {
    return await contactLocalRepository.getFriendContactById(params.accountId);
  }
}
