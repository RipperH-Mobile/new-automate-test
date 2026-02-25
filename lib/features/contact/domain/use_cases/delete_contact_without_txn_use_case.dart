import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteContactWithoutTxnUseCase extends SimpleUseCase<bool, String> {
  ContactLocalRepository get contactLocalRepository {
    return GetIt.I<ContactLocalRepository>();
  }

  @override
  Future<bool> call(String id) async {
    return await contactLocalRepository.deleteContactWithoutTxn(id);
  }
}
