import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ClearCollectionUseCase extends SimpleUseCaseSync<void, NoParams> {
  ContactLocalRepository get contactLocalRepository {
    return GetIt.I<ContactLocalRepository>();
  }

  @override
  Future<void> call(NoParams params) async {
    return contactLocalRepository.clearCollection();
  }
}
