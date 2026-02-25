import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAnyAccountHasShortcutPasscodeUseCase extends SimpleUseCase<bool, NoParams> {
  final UserLocalRepository userLocalRepository;

  GetAnyAccountHasShortcutPasscodeUseCase({
    required this.userLocalRepository,
  });

  @override
  Future<bool> call(NoParams params) async {
    return await userLocalRepository.getAnyAccountHasShortcutPasscode();
  }
}
