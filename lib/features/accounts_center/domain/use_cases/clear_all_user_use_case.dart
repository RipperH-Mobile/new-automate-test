import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ClearAllUserUseCase extends SimpleUseCase<void, NoParams> {
  final UserLocalRepository userLocalRepository;

  ClearAllUserUseCase({required this.userLocalRepository});

  @override
  Future<void> call(NoParams params) async {
    await userLocalRepository.clearUser();
  }
}
