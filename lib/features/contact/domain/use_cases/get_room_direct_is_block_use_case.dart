import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomDirectIsBlockUseCase extends SimpleUseCaseSync<bool, String> {
  final ContactLocalRepository contactLocalRepository;

  GetRoomDirectIsBlockUseCase({
    required this.contactLocalRepository,
  });

  @override
  bool call(String params) {
    return contactLocalRepository.isDirectRoomBlocked(params);
  }
}
