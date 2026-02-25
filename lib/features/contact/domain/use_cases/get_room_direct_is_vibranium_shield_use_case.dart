import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetRoomDirectIsVibraniumShieldUseCase extends SimpleUseCaseSync<bool, String> {
  final ContactLocalRepository contactLocalRepository;

  GetRoomDirectIsVibraniumShieldUseCase({
    required this.contactLocalRepository,
  });

  @override
  bool call(String params) {
    return contactLocalRepository.isDirectRoomVibraniumShield(params);
  }
}
