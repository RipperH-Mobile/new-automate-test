import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SetShortcutPasscodeParams {
  final String userId;
  final String? passcode;

  SetShortcutPasscodeParams({
    required this.userId,
    required this.passcode,
  });
}

class SetShortCutPasscodeUseCase extends SimpleUseCase<bool, SetShortcutPasscodeParams> {
  final UserLocalRepository userLocalRepository;

  SetShortCutPasscodeUseCase({
    required this.userLocalRepository,
  });

  @override
  Future<bool> call(SetShortcutPasscodeParams params) async {
    final user = await userLocalRepository.getUser(params.userId);
    if (user == null) return false;
    final newUser = user.copyWith(
      shortcutPasscode: params.passcode,
      forceDeleteShortcutPasscode: params.passcode == null,
    );
    await userLocalRepository.putUser(newUser);

    return true;
  }
}
