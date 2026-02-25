import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class FindUserWithShortcutPasscodeParams {
  final String passcode;

  FindUserWithShortcutPasscodeParams({required this.passcode});
}

class FindUserWithShortcutPasscodeUseCase extends SimpleUseCase<UserEntity?, FindUserWithShortcutPasscodeParams> {
  final UserLocalRepository userLocalRepository;

  FindUserWithShortcutPasscodeUseCase({required this.userLocalRepository});

  @override
  Future<UserEntity?> call(FindUserWithShortcutPasscodeParams params) async {
    return await userLocalRepository.findUserWithShortcutPasscode(params.passcode);
  }
}
